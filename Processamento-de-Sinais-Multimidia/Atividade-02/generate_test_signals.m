function [x_noise, x_music, x_voice, fs] = generate_test_signals()
%GENERATE_TEST_SIGNALS Gera os três tipos de sinais para análise
%
% Saídas:
%   x_noise - sinal aleatório limitado em frequência
%   x_music - sinal contendo notas musicais
%   x_voice - sinal de voz sintético
%   fs      - frequência de amostragem

% Parâmetros gerais
fs = 16000;  % Hz
duration = 4;  % segundos
t = (0:1/fs:duration-1/fs)';
N = length(t);

%% 1. Sinal aleatório limitado em frequência
% Ruído branco gaussiano filtrado passa-baixas (fc = 2000 Hz)
fc_noise = 2000;  % frequência de corte
[b, a] = butter(6, fc_noise/(fs/2), 'low');

% Gerar ruído branco
white_noise = randn(N, 1);

% Filtrar o ruído
x_noise = filter(b, a, white_noise);

% Normalizar
x_noise = x_noise / max(abs(x_noise)) * 0.8;

%% 2. Sinal contendo notas musicais
% Sequência de notas: C4, D4, E4, F4, G4, A4, B4, C5
notas_freq = [261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25];
nota_duration = duration / length(notas_freq);
samples_per_nota = round(nota_duration * fs);

x_music = zeros(N, 1);
for i = 1:length(notas_freq)
    start_idx = (i-1) * samples_per_nota + 1;
    end_idx = min(i * samples_per_nota, N);
    t_nota = (0:end_idx-start_idx)' / fs;
    
    % Fundamental + harmônicos para tornar mais realista
    fundamental = sin(2*pi*notas_freq(i)*t_nota);
    harmonico2 = 0.5 * sin(2*pi*2*notas_freq(i)*t_nota);
    harmonico3 = 0.25 * sin(2*pi*3*notas_freq(i)*t_nota);
    
    % Envelope de ataque e decaimento
    envelope = exp(-2*t_nota) .* (1 - exp(-10*t_nota));
    
    nota = envelope .* (fundamental + harmonico2 + harmonico3);
    x_music(start_idx:end_idx) = nota;
end

% Normalizar
x_music = x_music / max(abs(x_music)) * 0.8;

%% 3. Sinal de voz sintético
% Simular uma sequência de vogais com formantes
% Frequência fundamental variável (pitch contour)
f0_base = 150;  % Hz
f0_variation = 30 * sin(2*pi*0.5*t);  % variação de pitch
f0 = f0_base + f0_variation;

% Integrar a fase para frequência variável
phase = cumsum(2*pi*f0/fs);

% Fundamental
fundamental = sin(phase);

% Segundo harmônico com modulação
harmonico2 = 0.6 * sin(2*phase);

% Terceiro harmônico
harmonico3 = 0.3 * sin(3*phase);

% Combinar harmônicos
voice_harmonic = fundamental + harmonico2 + harmonico3;

% Simular formantes (filtros passa-banda)
% F1 ~ 800 Hz, F2 ~ 1200 Hz (aproximação de vogais)
[b1, a1] = butter(4, [700 900]/(fs/2), 'bandpass');
[b2, a2] = butter(4, [1100 1300]/(fs/2), 'bandpass');

formant1 = filter(b1, a1, voice_harmonic);
formant2 = filter(b2, a2, voice_harmonic);

% Combinar formantes
x_voice = voice_harmonic + 0.8*formant1 + 0.6*formant2;

% Envelope global (fade in/out)
envelope_global = hann(N, 'periodic');
x_voice = x_voice .* envelope_global;

% Normalizar
x_voice = x_voice / max(abs(x_voice)) * 0.8;

fprintf('Sinais de teste gerados:\n');
fprintf('- Ruído filtrado (fc = %d Hz)\n', fc_noise);
fprintf('- Música: %d notas musicais\n', length(notas_freq));
fprintf('- Voz: sinal sintético com f0 = %.0f ± %.0f Hz\n', f0_base, max(abs(f0_variation)));
fprintf('- Frequência de amostragem: %d Hz\n', fs);
fprintf('- Duração: %.1f segundos\n', duration);

end