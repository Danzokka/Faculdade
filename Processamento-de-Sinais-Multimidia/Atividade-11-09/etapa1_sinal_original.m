% Atividade: Transformada de Wavelets para Suavização de Sinal
% Etapa 1: Criação do sinal original

% Parâmetros do sinal
fs = 1e3;  % Frequência de amostragem
t = 1/fs:1/fs:1;  % Vetor de tempo
x = sin(4*pi*t);  % Sinal senoidal

% Plotagem do sinal original
figure(1);
plot(t, x);
title('Sinal Original - Senoide');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

% Verificação se é uma senoide de baixa frequência
fprintf('Sinal criado: senoide com frequência de %.1f Hz\n', 2);
fprintf('Frequência de amostragem: %.0f Hz\n', fs);
fprintf('Duração do sinal: %.1f s\n', max(t));
