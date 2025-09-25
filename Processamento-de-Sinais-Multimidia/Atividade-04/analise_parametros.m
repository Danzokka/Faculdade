% Atividade 4 - Análise de Sensibilidade dos Parâmetros
% Teste com diferentes valores de k e limiar

% Carrega dados das etapas anteriores
if ~exist('sinal_denoised_2G', 'var')
    run('denoising_2G.m');
end

fprintf('\n=== ANÁLISE DE SENSIBILIDADE DOS PARÂMETROS ===\n');

% Teste com diferentes conjuntos de valores de k
k_sets = {
    [0, 1, 2, 3],           % Conjunto original
    [0, 2, 4, 6],           % Deslocamentos maiores
    [0, 1, 2, 3, 4, 5],     % Mais deslocamentos
    [0, 3, 6, 9],           % Deslocamentos espaçados
    [0, 1]                  % Apenas 2 deslocamentos
};

k_set_names = {
    'Original [0,1,2,3]',
    'Maiores [0,2,4,6]',
    'Mais valores [0,1,2,3,4,5]',
    'Espaçados [0,3,6,9]',
    'Simples [0,1]'
};

% Teste com diferentes thresholds
threshold_factors = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
threshold_base = threshold_1G;

fprintf('Testando diferentes conjuntos de k:\n');

% Armazenar resultados
resultados_k = struct();
resultados_threshold = struct();

% Teste dos diferentes conjuntos de k
for set_idx = 1:length(k_sets)
    k_test = k_sets{set_idx};
    N_k = length(k_test);
    
    % Matriz para versões processadas
    versoes_k = zeros(N_k, length(sinal_ruidoso));
    
    % Processamento para cada k
    for i = 1:N_k
        k = k_test(i);
        
        % Deslocamento
        if k == 0
            sinal_temp = sinal_ruidoso;
        else
            sinal_temp = circshift(sinal_ruidoso, k);
        end
        
        % Denoising 1G
        [coeff, comp] = wavedec(sinal_temp, niveis_2G, wavelet_2G);
        coeff_th = wthresh(coeff, 's', threshold_base);
        sinal_rec = waverec(coeff_th, comp, wavelet_2G);
        
        % Deslocamento inverso
        if k == 0
            versoes_k(i, :) = sinal_rec;
        else
            versoes_k(i, :) = circshift(sinal_rec, -k);
        end
    end
    
    % Média das versões
    resultado_k = mean(versoes_k, 1);
    
    % Cálculo de métricas
    snr_k = 10 * log10(var(sinal_original) / var(sinal_original - resultado_k));
    mse_k = mean((sinal_original - resultado_k).^2);
    
    % Armazenar resultados
    resultados_k(set_idx).nome = k_set_names{set_idx};
    resultados_k(set_idx).k_values = k_test;
    resultados_k(set_idx).sinal = resultado_k;
    resultados_k(set_idx).snr = snr_k;
    resultados_k(set_idx).mse = mse_k;
    
    fprintf('  %s: SNR = %.2f dB, MSE = %.6f\n', k_set_names{set_idx}, snr_k, mse_k);
end

fprintf('\nTestando diferentes fatores de threshold:\n');

% Teste dos diferentes thresholds
k_fixo = [0, 1, 2, 3];  % Usar k original
for th_idx = 1:length(threshold_factors)
    factor = threshold_factors(th_idx);
    threshold_test = threshold_base * factor;
    
    % Processamento com threshold modificado
    versoes_th = zeros(length(k_fixo), length(sinal_ruidoso));
    
    for i = 1:length(k_fixo)
        k = k_fixo(i);
        
        % Deslocamento
        if k == 0
            sinal_temp = sinal_ruidoso;
        else
            sinal_temp = circshift(sinal_ruidoso, k);
        end
        
        % Denoising com threshold modificado
        [coeff, comp] = wavedec(sinal_temp, niveis_2G, wavelet_2G);
        coeff_th = wthresh(coeff, 's', threshold_test);
        sinal_rec = waverec(coeff_th, comp, wavelet_2G);
        
        % Deslocamento inverso
        if k == 0
            versoes_th(i, :) = sinal_rec;
        else
            versoes_th(i, :) = circshift(sinal_rec, -k);
        end
    end
    
    % Média das versões
    resultado_th = mean(versoes_th, 1);
    
    % Cálculo de métricas
    snr_th = 10 * log10(var(sinal_original) / var(sinal_original - resultado_th));
    mse_th = mean((sinal_original - resultado_th).^2);
    
    % Armazenar resultados
    resultados_threshold(th_idx).factor = factor;
    resultados_threshold(th_idx).threshold = threshold_test;
    resultados_threshold(th_idx).sinal = resultado_th;
    resultados_threshold(th_idx).snr = snr_th;
    resultados_threshold(th_idx).mse = mse_th;
    
    fprintf('  Fator %.2f (th=%.4f): SNR = %.2f dB, MSE = %.6f\n', ...
            factor, threshold_test, snr_th, mse_th);
end

% Plotagem dos resultados de diferentes k
figure(7);
for i = 1:length(k_sets)
    subplot(length(k_sets), 1, i);
    plot(resultados_k(i).sinal);
    title(sprintf('%s - SNR: %.2f dB', resultados_k(i).nome, resultados_k(i).snr));
    xlabel('Amostras');
    ylabel('Amplitude');
    grid on;
end

% Plotagem dos resultados de diferentes thresholds
figure(8);
snr_values = [resultados_threshold.snr];
plot(threshold_factors, snr_values, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
title('SNR vs Fator de Threshold');
xlabel('Fator de Threshold');
ylabel('SNR (dB)');
grid on;

% Encontrar parâmetros ótimos
[max_snr_k, idx_k] = max([resultados_k.snr]);
[max_snr_th, idx_th] = max([resultados_threshold.snr]);

fprintf('\n=== PARÂMETROS ÓTIMOS ===\n');
fprintf('Melhor conjunto de k: %s (SNR = %.2f dB)\n', ...
        resultados_k(idx_k).nome, max_snr_k);
fprintf('Melhor fator de threshold: %.2f (SNR = %.2f dB)\n', ...
        threshold_factors(idx_th), max_snr_th);
