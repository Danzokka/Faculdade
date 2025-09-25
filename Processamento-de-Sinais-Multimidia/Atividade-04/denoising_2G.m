% Atividade 4 - Implementação do Denoising de 2ª Geração (2G)
% Método de denoising circular com deslocamentos

% Carrega dados das etapas anteriores
if ~exist('sinal_denoised_1G', 'var')
    run('denoising_1G.m');
end

fprintf('\n=== DENOISING DE 2ª GERAÇÃO (2G) ===\n');

% Parâmetros para denoising 2G
k_values = [0, 1, 2, 3];  % Valores de deslocamento conforme exemplo
N_deslocamentos = length(k_values);

% Parâmetros da wavelet (mesmos do 1G)
wavelet_2G = 'db4';
niveis_2G = 6;

fprintf('Parâmetros do Denoising 2G:\n');
fprintf('- Wavelet: %s\n', wavelet_2G);
fprintf('- Níveis: %d\n', niveis_2G);
fprintf('- Deslocamentos k: [%s]\n', num2str(k_values));
fprintf('- Número de versões: %d\n', N_deslocamentos);

% Matriz para armazenar as versões processadas
sinais_deslocados = zeros(N_deslocamentos, length(sinal_ruidoso));
sinais_processados = zeros(N_deslocamentos, length(sinal_ruidoso));

% Aplicação do denoising 2G
for i = 1:N_deslocamentos
    k = k_values(i);
    
    % Deslocamento circular (shift)
    if k == 0
        sinal_deslocado = sinal_ruidoso;
    else
        sinal_deslocado = circshift(sinal_ruidoso, k);
    end
    
    % Armazenar sinal deslocado
    sinais_deslocados(i, :) = sinal_deslocado;
    
    % Decomposição wavelet
    [coeff, comprimentos] = wavedec(sinal_deslocado, niveis_2G, wavelet_2G);
    
    % Aplicação do threshold (mesmo threshold do 1G)
    coeff_threshold = wthresh(coeff, 's', threshold_1G);
    
    % Reconstrução
    sinal_reconstruido = waverec(coeff_threshold, comprimentos, wavelet_2G);
    
    % Deslocamento inverso
    if k == 0
        sinal_processado = sinal_reconstruido;
    else
        sinal_processado = circshift(sinal_reconstruido, -k);
    end
    
    % Armazenar sinal processado
    sinais_processados(i, :) = sinal_processado;
    
    fprintf('Processamento k=%d concluído\n', k);
end

% Cálculo da média das versões processadas (resultado final 2G)
sinal_denoised_2G = mean(sinais_processados, 1);

% Cálculo do ganho de SNR para 2G
snr_2G = 10 * log10(var(sinal_original) / var(sinal_original - sinal_denoised_2G));
ganho_snr_2G = snr_2G - snr_original;

fprintf('\nResultados do Denoising 2G:\n');
fprintf('- SNR após 2G: %.2f dB\n', snr_2G);
fprintf('- Ganho SNR (2G): %.2f dB\n', ganho_snr_2G);
fprintf('- Melhoria 2G vs 1G: %.2f dB\n', snr_2G - snr_1G);

% Plotagem das versões processadas
figure(4);
for i = 1:N_deslocamentos
    subplot(N_deslocamentos, 1, i);
    plot(sinais_processados(i, :));
    title(sprintf('Versão Processada k=%d', k_values(i)));
    xlabel('Amostras');
    ylabel('Amplitude');
    grid on;
end

% Plotagem do resultado final
figure(5);
subplot(3,1,1);
plot(sinal_original, 'g-', 'LineWidth', 1.5);
title('Sinal Original');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(sinal_denoised_1G, 'b-', 'LineWidth', 1.2);
title('Resultado Denoising 1G');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(sinal_denoised_2G, 'r-', 'LineWidth', 1.2);
title('Resultado Denoising 2G');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

% Comparação final
figure(6);
plot(sinal_original, 'g-', 'LineWidth', 1.5);
hold on;
plot(sinal_ruidoso, 'k-', 'LineWidth', 0.6);
plot(sinal_denoised_1G, 'b-', 'LineWidth', 1.2);
plot(sinal_denoised_2G, 'r-', 'LineWidth', 1.2);
title('Comparação Final: Original vs 1G vs 2G');
xlabel('Amostras');
ylabel('Amplitude');
legend('Original', 'Ruidoso', 'Denoised 1G', 'Denoised 2G', 'Location', 'best');
grid on;
hold off;
