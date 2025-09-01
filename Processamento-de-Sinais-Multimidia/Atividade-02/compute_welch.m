function [S_welch, f] = compute_welch(x, fs, segment_ms, overlap_pct, windowType)
%COMPUTE_WELCH Implementa o método de Welch para estimativa espectral
%
% Entradas:
%   x           - sinal de entrada (vetor coluna)
%   fs          - frequência de amostragem (Hz)
%   segment_ms  - duração da janela em milissegundos
%   overlap_pct - percentual de sobreposição (0-99)
%   windowType  - tipo de janela ('hann', 'hamming', 'rect')
%
% Saídas:
%   S_welch     - estimativa espectral pelo método de Welch
%   f           - vetor de frequências correspondente

arguments
    x (:,1) double
    fs (1,1) double {mustBePositive}
    segment_ms (1,1) double {mustBePositive}
    overlap_pct (1,1) double {mustBeGreaterThanOrEqual(overlap_pct,0), mustBeLessThan(overlap_pct,100)} = 50
    windowType (1,:) char {mustBeMember(windowType,{'hann','hamming','rect'})} = 'hann'
end

% Parâmetros da janela
Nw = round(segment_ms * 1e-3 * fs);  % comprimento da janela em amostras
if Nw < 8
    error('Comprimento da janela muito pequeno (<8 amostras). Aumente segment_ms.');
end

% Sobreposição
hop = max(1, round(Nw * (1 - overlap_pct/100)));

% Construir janela
switch windowType
    case 'hann'
        w = hann(Nw, 'periodic');
    case 'hamming'
        w = hamming(Nw, 'periodic');
    otherwise
        w = ones(Nw, 1);
end

% Normalização da janela para manter energia
w = w / sqrt(sum(w.^2));

N = length(x);
% Número de janelas
M = 1 + floor((N - Nw) / hop);

if M < 1
    error('Sinal muito curto para segmentação.');
end

% Tamanho da FFT
Nfft = 2^nextpow2(Nw);
K = Nfft/2 + 1;  % espectro unilateral

% Inicializar acumulador
S_welch = zeros(K, 1);
validSegments = 0;

% Processar cada segmento
for m = 1:M
    startIdx = (m-1) * hop + 1;
    endIdx = startIdx + Nw - 1;
    
    if endIdx <= N
        % Extrair segmento e aplicar janela
        segment = x(startIdx:endIdx) .* w;
        
        % Calcular FFT
        X = fft(segment, Nfft);
        
        % Densidade espectral de potência unilateral
        Px = abs(X(1:K)).^2 / (fs * Nw);
        
        % Correção para frequências não-DC e não-Nyquist
        Px(2:end-1) = 2 * Px(2:end-1);
        
        % Acumular
        S_welch = S_welch + Px;
        validSegments = validSegments + 1;
    end
end

% Média dos periodogramas
if validSegments > 0
    S_welch = S_welch / validSegments;
else
    error('Nenhum segmento válido encontrado.');
end

% Vetor de frequências
f = (0:K-1)' * fs / Nfft;

end