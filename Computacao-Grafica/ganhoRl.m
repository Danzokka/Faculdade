% Definindo os parâmetros
R = 1e3; % 1k ohm
L = 1; % 1 H
f = logspace(0, 5, 1000); % Frequências de 1Hz a 100kHz

% Magnitude do ganho para o filtro passa-baixa RL
H_PB_RL = R ./ sqrt(R^2 + (2 * pi * f * L).^2);

% Magnitude do ganho para o filtro passa-alta RL
H_PA_RL = (2 * pi * f * L) ./ sqrt(R^2 + (2 * pi * f * L).^2);

% Plotando os gráficos
figure;
loglog(f, H_PB_RL); % Plot para o filtro passa-baixa
hold on;
loglog(f, H_PA_RL); % Plot para o filtro passa-alta
hold off;
title('Magnitude do Ganho dos Filtros RL');
xlabel('Frequência (Hz)');
ylabel('Magnitude do Ganho');
legend('Passa-Baixa', 'Passa-Alta');
grid on;
