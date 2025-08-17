function [X, f, t, peakFreqHz, peakIdx] = compute_stft(x, fs, segment_ms, overlap_pct, windowType)
% COMPUTE_STFT  Short-Time Fourier Transform (simple academic implementation)
%
%   [X, f, t, peakFreqHz, peakIdx] = compute_stft(x, fs, segment_ms, overlap_pct, windowType)
%
% INPUTS
%   x           : (Nx1) real (or complex) time-domain signal samples.
%   fs          : sampling frequency in Hz.
%   segment_ms  : window length for each DFT in milliseconds.
%   overlap_pct : (optional) percentage overlap between consecutive windows (0-90). Default 50.
%   windowType  : (optional) 'hann' (default), 'hamming', 'rect'.
%
% OUTPUTS
%   X           : (K x M) complex STFT matrix. Each column is the spectrum of a segment.
%                 K = Nfft/2+1 (one-sided, for real signals) or Nfft if complex input.
%   f           : (K x 1) frequency vector corresponding to rows of X (Hz).
%   t           : (1 x M) time instants (center of each window) in seconds.
%   peakFreqHz  : (1 x M) peak frequency (Hz) for each segment (max magnitude bin).
%   peakIdx     : (1 x M) index of the peak bin per segment (points into f / rows of X).
%
% NOTES
%   - This implementation keeps things explicit (loops) for pedagogical clarity.
%   - Zero-padding is applied ONLY if the last frame is shorter than the window length.
%   - A one-sided spectrum is returned for real signals (energy is NOT doubled).
%   - Magnitudes can be obtained with abs(X); power with abs(X).^2.
%
% EXAMPLE
%   fs = 8000; t = 0:1/fs:1; x = sin(2*pi*440*t); % 440 Hz tone
%   [X,f,tt,pk,~] = compute_stft(x, fs, 40, 50);
%   imagesc(tt, f, 20*log10(abs(X)+1e-6)); axis xy; colormap turbo; colorbar; ylabel('Hz'); xlabel('s');
%   title('Spectrogram (dB)');

arguments
    x (:,1) double
    fs (1,1) double {mustBePositive}
    segment_ms (1,1) double {mustBePositive}
    overlap_pct (1,1) double {mustBeGreaterThanOrEqual(overlap_pct,0), mustBeLessThan(overlap_pct,100)} = 50
    windowType (1,:) char {mustBeMember(windowType,{'hann','hamming','rect'})} = 'hann'
end

Nw = round(segment_ms*1e-3*fs); % window length in samples
if Nw < 8
    error('Window length too small (<8 samples). Increase segment_ms.');
end

hop = max(1, round(Nw * (1 - overlap_pct/100)));

% Build window
switch windowType
    case 'hann'
        w = hann(Nw, 'periodic');
    case 'hamming'
        w = hamming(Nw, 'periodic');
    otherwise
        w = ones(Nw,1);
end

N = length(x);
% Number of complete hops
M = 1 + floor((N - Nw)/hop);
lastStart = (M-1)*hop + 1;
remainder = N - (lastStart + Nw -1);
if remainder > 0
    % We'll include a partial frame (zero-padded)
    M = M + 1;
end

% Choose FFT size: next pow2 >= Nw for efficiency
Nfft = 2^nextpow2(Nw);

oneSided = isreal(x);
if oneSided
    K = Nfft/2 + 1;
else
    K = Nfft;
end

X = zeros(K, M); %#ok<PREALL>
t = zeros(1, M);
peakIdx = zeros(1,M);
peakFreqHz = zeros(1,M);

for m = 1:M
    startIdx = (m-1)*hop + 1;
    stopIdx  = startIdx + Nw - 1;
    if stopIdx <= N
        frame = x(startIdx:stopIdx);
    else
        % zero-pad last (partial) frame
        frame = zeros(Nw,1);
        avail = N - startIdx + 1;
        if avail > 0
            frame(1:avail) = x(startIdx:N);
        end
    end
    frameWin = frame .* w;
    Xfull = fft(frameWin, Nfft);
    if oneSided
        Xk = Xfull(1:K);
    else
        Xk = Xfull;
    end
    X(:,m) = Xk;
    centerSample = startIdx + (Nw-1)/2;
    t(m) = (centerSample-1)/fs; % seconds
    % Peak frequency (magnitude)
    [~, idx] = max(abs(Xk));
    peakIdx(m) = idx;
end

% Frequency vector
if oneSided
    f = (0:K-1).' * fs / Nfft;
else
    f = (-Nfft/2:Nfft/2-1).' * fs / Nfft; % (rare path for complex input)
end
for m = 1:M
    peakFreqHz(m) = f(peakIdx(m));
end

end
