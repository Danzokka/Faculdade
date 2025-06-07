% Definindo os parâmetros
R = 1e3; % 1k ohm
C = 1e-6; % 1uF
f = logspace(0, 5, 1000); % Criando um vetor de frequências em escala logarítmica de 1Hz a 100kHz

% Calculando a magnitude do ganho para passa-baixa
H_PB = 1 ./ sqrt(1 + (2 * pi * f * R * C).^2);

% Calculando a magnitude do ganho para passa-alta
H_PA = (2 * pi * f * R * C) ./ sqrt(1 + (2 * pi * f * R * C).^2);

% Plotando os gráficos
figure;
loglog(f, H_PB); % loglog plota ambos os eixos em escala logarítmica
hold on; % Permite sobrepor outro gráfico
loglog(f, H_PA);
hold off;
title('Magnitude do Ganho dos Filtros RC');
xlabel('Frequência (Hz)');
ylabel('Magnitude do Ganho');
legend('Passa-Baixa', 'Passa-Alta');
grid on;