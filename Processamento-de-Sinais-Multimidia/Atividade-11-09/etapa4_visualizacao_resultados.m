% Atividade: Transformada de Wavelets para Suavização de Sinal
% Etapa 4: Visualização dos resultados

% Carrega variáveis das etapas anteriores (se executado separadamente)
if ~exist('y', 'var')
    run('etapa3_filtragem_wavelet.m');
end

% Plotagem comparativa dos sinais
figure(5);
plot(t, x_ruidoso, 'b-', 'LineWidth', 1);
hold on;
plot(t, y, 'r-', 'LineWidth', 2);
plot(t, x, 'g--', 'LineWidth', 1.5);
title('Comparação: Sinal Ruidoso vs Sinal Filtrado vs Sinal Original');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Sinal Ruidoso', 'Sinal Filtrado', 'Sinal Original', 'Location', 'best');
grid on;
hold off;

% Cálculo do erro quadrático médio (MSE)
mse_antes = mean((x - x_ruidoso).^2);
mse_depois = mean((x - y).^2);

% Cálculo da relação sinal-ruído (SNR)
snr_antes = 10*log10(var(x)/var(x_ruidoso - x));
snr_depois = 10*log10(var(x)/var(y - x));

% Resultados numéricos
fprintf('\n=== RESULTADOS DA FILTRAGEM ===\n');
fprintf('MSE antes da filtragem: %.6f\n', mse_antes);
fprintf('MSE depois da filtragem: %.6f\n', mse_depois);
fprintf('Melhoria no MSE: %.2f%%\n', ((mse_antes - mse_depois)/mse_antes)*100);
fprintf('\nSNR antes da filtragem: %.2f dB\n', snr_antes);
fprintf('SNR depois da filtragem: %.2f dB\n', snr_depois);
fprintf('Melhoria no SNR: %.2f dB\n', snr_depois - snr_antes);

% Plotagem individual para melhor visualização
figure(6);
subplot(3,1,1);
plot(t, x, 'g-', 'LineWidth', 1.5);
title('Sinal Original');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, x_ruidoso, 'b-');
title('Sinal com Ruído');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, y, 'r-', 'LineWidth', 1.5);
title('Sinal Filtrado com Wavelets');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;
