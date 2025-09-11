% Atividade: Comparação entre diferentes amplitudes de ruído
% Questão 10: Comparação entre itens 4 e 9

% Carrega sinal original
if ~exist('x', 'var')
    run('etapa1_sinal_original.m');
end

% Parâmetros de filtragem
N = 5;
wavelet_name = 'db4';
Ind = 35;

% Caso 1: Ruído baixo (A = 0.1)
A1 = 0.1;
ruido1 = A1 * randn(size(x));
x_ruidoso1 = x + ruido1;

[C1, L1] = wavedec(x_ruidoso1, N, wavelet_name);
Y1 = C1;
Y1(Ind:end) = 0;
y_filtrado1 = waverec(Y1, L1, wavelet_name);

% Caso 2: Ruído forte (A = 0.3)
A2 = 0.3;
ruido2 = A2 * randn(size(x));
x_ruidoso2 = x + ruido2;

[C2, L2] = wavedec(x_ruidoso2, N, wavelet_name);
Y2 = C2;
Y2(Ind:end) = 0;
y_filtrado2 = waverec(Y2, L2, wavelet_name);

% Plotagem comparativa
figure(9);
subplot(2,2,1);
plot(t, x_ruidoso1, 'b-', 'LineWidth', 1);
hold on;
plot(t, y_filtrado1, 'r-', 'LineWidth', 1.5);
plot(t, x, 'g--', 'LineWidth', 1);
title('Caso 1: Ruído Baixo (A = 0.1)');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Ruidoso', 'Filtrado', 'Original', 'Location', 'best');
grid on;
hold off;

subplot(2,2,2);
plot(t, x_ruidoso2, 'b-', 'LineWidth', 1);
hold on;
plot(t, y_filtrado2, 'r-', 'LineWidth', 1.5);
plot(t, x, 'g--', 'LineWidth', 1);
title('Caso 2: Ruído Forte (A = 0.3)');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Ruidoso', 'Filtrado', 'Original', 'Location', 'best');
grid on;
hold off;

subplot(2,2,3);
plot(t, y_filtrado1, 'r-', 'LineWidth', 1.5);
hold on;
plot(t, x, 'g--', 'LineWidth', 1.5);
title('Resultado Filtrado - Ruído Baixo');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Filtrado', 'Original', 'Location', 'best');
grid on;
hold off;

subplot(2,2,4);
plot(t, y_filtrado2, 'r-', 'LineWidth', 1.5);
hold on;
plot(t, x, 'g--', 'LineWidth', 1.5);
title('Resultado Filtrado - Ruído Forte');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Filtrado', 'Original', 'Location', 'best');
grid on;
hold off;

sgtitle('Comparação: Ruído Baixo vs Ruído Forte');

% Cálculo de métricas comparativas
mse1_antes = mean((x - x_ruidoso1).^2);
mse1_depois = mean((x - y_filtrado1).^2);
mse2_antes = mean((x - x_ruidoso2).^2);
mse2_depois = mean((x - y_filtrado2).^2);

snr1_antes = 10*log10(var(x)/var(x_ruidoso1 - x));
snr1_depois = 10*log10(var(x)/var(y_filtrado1 - x));
snr2_antes = 10*log10(var(x)/var(x_ruidoso2 - x));
snr2_depois = 10*log10(var(x)/var(y_filtrado2 - x));

fprintf('=== COMPARAÇÃO ENTRE RUÍDO BAIXO E FORTE ===\n\n');
fprintf('RUÍDO BAIXO (A = 0.1):\n');
fprintf('  MSE antes: %.6f | MSE depois: %.6f | Melhoria: %.2f%%\n', ...
        mse1_antes, mse1_depois, ((mse1_antes-mse1_depois)/mse1_antes)*100);
fprintf('  SNR antes: %.2f dB | SNR depois: %.2f dB | Melhoria: %.2f dB\n\n', ...
        snr1_antes, snr1_depois, snr1_depois-snr1_antes);

fprintf('RUÍDO FORTE (A = 0.3):\n');
fprintf('  MSE antes: %.6f | MSE depois: %.6f | Melhoria: %.2f%%\n', ...
        mse2_antes, mse2_depois, ((mse2_antes-mse2_depois)/mse2_antes)*100);
fprintf('  SNR antes: %.2f dB | SNR depois: %.2f dB | Melhoria: %.2f dB\n\n', ...
        snr2_antes, snr2_depois, snr2_depois-snr2_antes);
