% Atividade 4 - Arquivo Principal
% Executa toda a sequência da atividade de Denoising

clear; clc; close all;

fprintf('====================================================\n');
fprintf('  ATIVIDADE 4 - DENOISING DE 2ª GERAÇÃO (DWT)\n');
fprintf('====================================================\n\n');

% Etapa 1: Inicialização e carregamento dos dados
fprintf('ETAPA 1: Inicialização...\n');
run('atividade4_init.m');

% Etapa 2: Denoising de 1ª Geração
fprintf('\nETAPA 2: Aplicando Denoising de 1ª Geração...\n');
run('denoising_1G.m');

% Etapa 3: Denoising de 2ª Geração
fprintf('\nETAPA 3: Aplicando Denoising de 2ª Geração...\n');
run('denoising_2G.m');

% Etapa 4: Análise de sensibilidade dos parâmetros
fprintf('\nETAPA 4: Análise de sensibilidade dos parâmetros...\n');
run('analise_parametros.m');

% Resumo final dos resultados
fprintf('\n====================================================\n');
fprintf('  RESUMO FINAL DOS RESULTADOS\n');
fprintf('====================================================\n');
fprintf('SNR do sinal ruidoso: %.2f dB\n', snr_original);
fprintf('SNR após Denoising 1G: %.2f dB (ganho: %.2f dB)\n', snr_1G, ganho_snr_1G);
fprintf('SNR após Denoising 2G: %.2f dB (ganho: %.2f dB)\n', snr_2G, ganho_snr_2G);
fprintf('Melhoria 2G vs 1G: %.2f dB\n', snr_2G - snr_1G);

% Cálculo de métricas adicionais
mse_ruido = mean((sinal_original - sinal_ruidoso).^2);
mse_1G = mean((sinal_original - sinal_denoised_1G).^2);
mse_2G = mean((sinal_original - sinal_denoised_2G).^2);

fprintf('\nMétricas de Erro Quadrático Médio (MSE):\n');
fprintf('MSE sinal ruidoso: %.6f\n', mse_ruido);
fprintf('MSE após 1G: %.6f (redução: %.2f%%)\n', mse_1G, (1-mse_1G/mse_ruido)*100);
fprintf('MSE após 2G: %.6f (redução: %.2f%%)\n', mse_2G, (1-mse_2G/mse_ruido)*100);

fprintf('\n====================================================\n');
fprintf('  ATIVIDADE CONCLUÍDA COM SUCESSO!\n');
fprintf('====================================================\n');
