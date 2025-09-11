% Atividade: Transformada de Wavelets para Suavização de Sinal
% Etapa 2: Adição de ruído ao sinal

% Carrega variáveis da etapa anterior (se executado separadamente)
if ~exist('x', 'var')
    run('etapa1_sinal_original.m');
end

% Adição de ruído aleatório
A = 0.1;  % Amplitude do ruído (10% da amplitude do sinal)
ruido = A * randn(size(x));
x_ruidoso = x + ruido;

% Plotagem do sinal ruidoso
figure(2);
plot(t, x_ruidoso);
title('Sinal com Ruído Adicionado');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

% Comparação entre sinal original e ruidoso
figure(3);
subplot(2,1,1);
plot(t, x);
title('Sinal Original');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, x_ruidoso);
title('Sinal com Ruído');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

fprintf('Ruído adicionado com amplitude A = %.1f (%.0f%% da amplitude do sinal)\n', A, A*100);
