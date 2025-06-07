% Dados da tabela
frequencia = [25, 50, 100, 200, 400, 800, 1600, 3200, 6400, 12800, 25600, 51200, 102400];
rl_indutor = [108.7, 208.6, 367.2, 539.0, 644.6, 685.6, 698.9, 704.7, 705.3, 706.0, 706.1, 706.1, 706.2];
rl_resistor = [697.6, 673.7, 599, 443.9, 267.8, 144.3, 74.6, 36.64, 17.92, 8.833, 4.393, 2.193, 1.096];

% Criar gráfico para o capacitor
figure;
semilogx(frequencia, rl_resistor, '-o'); % Semilogx usa escala logarítmica para o eixo x
title('RL Resistor vs Frequência');
xlabel('Frequência (Hz)');
ylabel('RL (Resistor) [mV]');
grid on;

% Ajustar os limites do eixo y, se necessário
ylim([0 max(rl_resistor)*1.1]);

% Ajustar os limites do eixo x para dar um pouco mais de espaço
xlim([min(frequencia)/2 max(frequencia)*2]);