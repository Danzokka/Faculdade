% Atividade: Teste com amplitude de ruído diferente
% Questão 8: Alterando amplitude do ruído para 0.3

% Carrega sinal original
if ~exist('x', 'var')
    run('etapa1_sinal_original.m');
end

% Nova amplitude de ruído
A_novo = 0.3;  % 30% da amplitude do sinal
ruido_forte = A_novo * randn(size(x));
x_ruidoso_forte = x + ruido_forte;

% Parâmetros da filtragem wavelet
N = 5;
wavelet_name = 'db4';
Ind = 35;

% Decomposição e filtragem
[C_forte, L_forte] = wavedec(x_ruidoso_forte, N, wavelet_name);
Y_forte = C_forte;
Y_forte(Ind:end) = 0;
y_filtrado_forte = waverec(Y_forte, L_forte, wavelet_name);

% Plotagem comparativa
figure(8);
plot(t, x_ruidoso_forte, 'b-', 'LineWidth', 1);
hold on;
plot(t, y_filtrado_forte, 'r-', 'LineWidth', 2);
plot(t, x, 'g--', 'LineWidth', 1.5);
title('Filtragem com Ruído de Alta Amplitude (A = 0.3)');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Sinal com Ruído Forte', 'Sinal Filtrado', 'Sinal Original', 'Location', 'best');
grid on;
hold off;

% Métricas
mse_antes_forte = mean((x - x_ruidoso_forte).^2);
mse_depois_forte = mean((x - y_filtrado_forte).^2);
snr_antes_forte = 10*log10(var(x)/var(x_ruidoso_forte - x));
snr_depois_forte = 10*log10(var(x)/var(y_filtrado_forte - x));

fprintf('=== RESULTADOS COM RUÍDO FORTE (A = 0.3) ===\n');
fprintf('MSE antes da filtragem: %.6f\n', mse_antes_forte);
fprintf('MSE depois da filtragem: %.6f\n', mse_depois_forte);
fprintf('Melhoria no MSE: %.2f%%\n', ((mse_antes_forte - mse_depois_forte)/mse_antes_forte)*100);
fprintf('\nSNR antes da filtragem: %.2f dB\n', snr_antes_forte);
fprintf('SNR depois da filtragem: %.2f dB\n', snr_depois_forte);
fprintf('Melhoria no SNR: %.2f dB\n', snr_depois_forte - snr_antes_forte);
