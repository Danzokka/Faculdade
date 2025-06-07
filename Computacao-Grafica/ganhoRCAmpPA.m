% Definindo os parâmetros
R = 1e3; % 1k ohm
C = 1e-6; % 1uF
f = logspace(0, 5, 1000); % Frequências de 1Hz a 100kHz

% Calculando a magnitude do ganho para o filtro passa-alta ativo
H_active_high = (2 * pi * f * R * C) ./ sqrt(1 + (2 * pi * f * R * C).^2);

% Plotando o gráfico
figure;
semilogx(f, 20*log10(H_active_high)); % Eixo x em escala logarítmica e ganho em dB
title('Magnitude do Ganho do Filtro Ativo Passa-Alta');
xlabel('Frequência (Hz)');
ylabel('Magnitude do Ganho (dB)');
grid on;
