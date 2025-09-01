function [S_bartlett, f] = compute_bartlett(x, fs, segment_ms, windowType)
%COMPUTE_BARTLETT Implementa o método de Bartlett para estimativa espectral
%
% Entradas:
%   x           - sinal de entrada (vetor coluna)
%   fs          - frequência de amostragem (Hz)
%   segment_ms  - duração da janela em milissegundos
%   windowType  - tipo de janela ('hann', 'hamming', 'rect')
%
% Saídas:
%   S_bartlett  - estimativa espectral pelo método de Bartlett
%   f           - vetor de frequências correspondente

arguments
    x (:,1) double
    fs (1,1) double {mustBePositive}
    segment_ms (1,1) double {mustBePositive}
    windowType (1,:) char {mustBeMember(windowType,{'hann','hamming','rect'})} = 'hann'
end

% Parâmetros da janela
Nw = round(segment_ms * 1e-3 * fs);  % comprimento da janela em amostras
if Nw < 8
    error('Comprimento da janela muito pequeno (<8 amostras). Aumente segment_ms.');
end

% Sem sobreposição no método de Bartlett
hop = Nw;

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
% Número de segmentos completos
M = floor(N / Nw);

if M < 1
    error('Sinal muito curto para segmentação.');
end

% Tamanho da FFT
Nfft = 2^nextpow2(Nw);
K = Nfft/2 + 1;  % espectro unilateral

% Inicializar acumulador
S_bartlett = zeros(K, 1);

% Processar cada segmento
for m = 1:M
    startIdx = (m-1) * Nw + 1;
    endIdx = startIdx + Nw - 1;
    
    % Extrair segmento e aplicar janela
    segment = x(startIdx:endIdx) .* w;
    
    % Calcular FFT
    X = fft(segment, Nfft);
    
    % Densidade espectral de potência unilateral
    Px = abs(X(1:K)).^2 / (fs * Nw);
    
    % Correção para frequências não-DC e não-Nyquist
    Px(2:end-1) = 2 * Px(2:end-1);
    
    % Acumular
    S_bartlett = S_bartlett + Px;
end

% Média dos periodogramas
S_bartlett = S_bartlett / M;

% Vetor de frequências
f = (0:K-1)' * fs / Nfft;

end