% Definindo os parâmetros
R = 1e3; % Resistência em ohms
L = 1; % Indutância em henries
C = 1e-6; % Capacitância em farads

% Calculando a frequência de ressonância
f0 = 1 / (2 * pi * sqrt(L * C));

% Criando um vetor de frequências em escala logarítmica
f = logspace(0, 5, 1000); % Frequências de 1Hz a 100kHz

% Calculando a magnitude do ganho para o filtro RLC passa-banda
H_RLC = 1 ./ sqrt(1 + ((f ./ f0) - (f0 ./ f)).^2);

% Plotando o gráfico
figure;
semilogx(f, H_RLC); % Eixo x em escala logarítmica
title('Magnitude do Ganho do Filtro RLC Passa-Banda');
xlabel('Frequência (Hz)');
ylabel('Magnitude do Ganho');
grid on;