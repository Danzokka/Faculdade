% Atividade 4 - Implementação do Denoising de 1ª Geração (1G)
% Método tradicional de denoising com threshold

% Carrega dados da inicialização
if ~exist('sinal_ruidoso', 'var')
    run('atividade4_init.m');
end

fprintf('\n=== DENOISING DE 1ª GERAÇÃO (1G) ===\n');

% Parâmetros para denoising 1G
wavelet_1G = 'db4';  % Wavelet Daubechies 4
niveis_1G = 6;       % Número de níveis de decomposição

% Decomposição wavelet
[coeff_1G, comprimentos_1G] = wavedec(sinal_ruidoso, niveis_1G, wavelet_1G);

% Estimativa do ruído usando MAD (Median Absolute Deviation)
% Usando os coeficientes de detalhe do primeiro nível
detalhe_1 = detcoef(coeff_1G, comprimentos_1G, 1);
sigma_ruido = median(abs(detalhe_1)) / 0.6745;

% Threshold baseado no critério de Donoho-Johnstone
N = length(sinal_ruidoso);
threshold_1G = sigma_ruido * sqrt(2 * log(N));

fprintf('Parâmetros do Denoising 1G:\n');
fprintf('- Wavelet: %s\n', wavelet_1G);
fprintf('- Níveis: %d\n', niveis_1G);
fprintf('- Sigma estimado: %.4f\n', sigma_ruido);
fprintf('- Threshold: %.4f\n', threshold_1G);

% Aplicação do threshold - Soft thresholding
coeff_threshold_1G = wthresh(coeff_1G, 's', threshold_1G);

% Reconstrução do sinal
sinal_denoised_1G = waverec(coeff_threshold_1G, comprimentos_1G, wavelet_1G);

% Cálculo do ganho de SNR
snr_original = 10 * log10(var(sinal_original) / var(ruido));
snr_1G = 10 * log10(var(sinal_original) / var(sinal_original - sinal_denoised_1G));
ganho_snr_1G = snr_1G - snr_original;

fprintf('\nResultados do Denoising 1G:\n');
fprintf('- SNR original: %.2f dB\n', snr_original);
fprintf('- SNR após 1G: %.2f dB\n', snr_1G);
fprintf('- Ganho SNR: %.2f dB\n', ganho_snr_1G);

% Plotagem dos resultados
figure(2);
subplot(4,1,1);
plot(sinal_original);
title('Sinal Original');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(4,1,2);
plot(sinal_ruidoso);
title('Sinal Ruidoso');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(4,1,3);
plot(sinal_denoised_1G);
title('Sinal após Denoising 1G');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(4,1,4);
plot(sinal_original - sinal_denoised_1G);
title('Erro (Original - Denoised 1G)');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

% Comparação visual
figure(3);
plot(sinal_original, 'g-', 'LineWidth', 1.5);
hold on;
plot(sinal_ruidoso, 'b-', 'LineWidth', 0.8);
plot(sinal_denoised_1G, 'r-', 'LineWidth', 1.2);
title('Comparação: Original vs Ruidoso vs Denoised 1G');
xlabel('Amostras');
ylabel('Amplitude');
legend('Original', 'Ruidoso', 'Denoised 1G', 'Location', 'best');
grid on;
hold off;
