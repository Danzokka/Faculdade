% Atividade 4 - Denoising usando arquivo sinais.mat
% Implementação específica para o arquivo .mat fornecido

clear; clc; close all;

fprintf('=== DENOISING USANDO ARQUIVO SINAIS.MAT ===\n\n');

% Carregamento e análise do arquivo .mat
try
    dados = load('sinais.mat');
    fprintf('Arquivo sinais.mat carregado com sucesso.\n');
    
    % Listar variáveis disponíveis
    nomes_vars = fieldnames(dados);
    fprintf('Variáveis disponíveis no arquivo:\n');
    for i = 1:length(nomes_vars)
        var_nome = nomes_vars{i};
        var_dados = dados.(var_nome);
        fprintf('  %s: %s\n', var_nome, class(var_dados));
        if isnumeric(var_dados)
            fprintf('    Tamanho: %s\n', mat2str(size(var_dados)));
            if isvector(var_dados)
                fprintf('    Comprimento: %d\n', length(var_dados));
                fprintf('    Min: %.4f, Max: %.4f, Média: %.4f\n', ...
                        min(var_dados), max(var_dados), mean(var_dados));
            end
        end
        fprintf('\n');
    end
    
catch ME
    fprintf('Erro ao carregar sinais.mat: %s\n', ME.message);
    fprintf('Criando sinais sintéticos para demonstração...\n');
    
    % Criar sinais sintéticos se o arquivo não for encontrado
    fs = 1000;
    t = 0:1/fs:2-1/fs;
    
    % Sinal 1: Senoide com ruído
    f1 = 50; % Hz
    sinal1 = sin(2*pi*f1*t) + 0.3*randn(size(t));
    
    % Sinal 2: Soma de senoides com ruído
    f2 = 30; f3 = 80;
    sinal2 = sin(2*pi*f2*t) + 0.5*sin(2*pi*f3*t) + 0.2*randn(size(t));
    
    % Sinal 3: Chirp com ruído
    sinal3 = chirp(t, 10, 2, 100) + 0.25*randn(size(t));
    
    dados.sinal1 = sinal1;
    dados.sinal2 = sinal2;
    dados.sinal3 = sinal3;
    dados.t = t;
    
    nomes_vars = {'sinal1', 'sinal2', 'sinal3', 't'};
end

% Seleção do sinal para processamento
sinais_numericos = {};
for i = 1:length(nomes_vars)
    var_nome = nomes_vars{i};
    var_dados = dados.(var_nome);
    if isnumeric(var_dados) && isvector(var_dados) && length(var_dados) > 100
        sinais_numericos{end+1} = var_nome;
    end
end

if isempty(sinais_numericos)
    error('Nenhum sinal adequado encontrado no arquivo.');
end

% Usar o primeiro sinal encontrado
sinal_nome = sinais_numericos{1};
sinal_dados = dados.(sinal_nome);

fprintf('Sinal selecionado para processamento: %s\n', sinal_nome);
fprintf('Comprimento do sinal: %d amostras\n', length(sinal_dados));

% Plotagem do sinal original
figure(1);
plot(sinal_dados);
title(sprintf('Sinal Original: %s', sinal_nome));
xlabel('Amostras');
ylabel('Amplitude');
grid on;

% Aplicação dos métodos de denoising
fprintf('\nAplicando Denoising de 1ª Geração...\n');

% Parâmetros
wavelet_name = 'db4';
niveis = 6;

% Estimativa do nível de ruído
% Assumindo que o ruído está presente nos coeficientes de alta frequência
[C, L] = wavedec(sinal_dados, niveis, wavelet_name);
detalhe_1 = detcoef(C, L, 1);
sigma_estimado = median(abs(detalhe_1)) / 0.6745;

% Threshold para denoising
N = length(sinal_dados);
threshold = sigma_estimado * sqrt(2 * log(N));

fprintf('Parâmetros de denoising:\n');
fprintf('  Sigma estimado: %.4f\n', sigma_estimado);
fprintf('  Threshold: %.4f\n', threshold);

% Denoising 1G
C_th = wthresh(C, 's', threshold);
sinal_1G = waverec(C_th, L, wavelet_name);

% Denoising 2G
fprintf('\nAplicando Denoising de 2ª Geração...\n');
k_values = [0, 1, 2, 3];
sinais_processados = zeros(length(k_values), length(sinal_dados));

for i = 1:length(k_values)
    k = k_values(i);
    
    % Deslocamento circular
    if k == 0
        sinal_shift = sinal_dados;
    else
        sinal_shift = circshift(sinal_dados, k);
    end
    
    % Denoising
    [C_shift, L_shift] = wavedec(sinal_shift, niveis, wavelet_name);
    C_shift_th = wthresh(C_shift, 's', threshold);
    sinal_rec = waverec(C_shift_th, L_shift, wavelet_name);
    
    % Deslocamento inverso
    if k == 0
        sinais_processados(i, :) = sinal_rec;
    else
        sinais_processados(i, :) = circshift(sinal_rec, -k);
    end
end

% Média das versões (resultado 2G)
sinal_2G = mean(sinais_processados, 1);

% Comparação visual
figure(2);
subplot(3,1,1);
plot(sinal_dados);
title('Sinal Original');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(sinal_1G);
title('Denoising 1ª Geração');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(sinal_2G);
title('Denoising 2ª Geração');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

% Comparação direta
figure(3);
plot(sinal_dados, 'b-', 'LineWidth', 1);
hold on;
plot(sinal_1G, 'r-', 'LineWidth', 1.2);
plot(sinal_2G, 'g-', 'LineWidth', 1.2);
title('Comparação dos Métodos de Denoising');
xlabel('Amostras');
ylabel('Amplitude');
legend('Original', '1ª Geração', '2ª Geração', 'Location', 'best');
grid on;
hold off;

% Análise espectral
figure(4);
subplot(3,1,1);
[psd_orig, f_orig] = pwelch(sinal_dados, [], [], [], 1000);
semilogy(f_orig, psd_orig);
title('PSD - Sinal Original');
xlabel('Frequência (Hz)');
ylabel('PSD');
grid on;

subplot(3,1,2);
[psd_1G, f_1G] = pwelch(sinal_1G, [], [], [], 1000);
semilogy(f_1G, psd_1G);
title('PSD - Denoising 1G');
xlabel('Frequência (Hz)');
ylabel('PSD');
grid on;

subplot(3,1,3);
[psd_2G, f_2G] = pwelch(sinal_2G, [], [], [], 1000);
semilogy(f_2G, psd_2G);
title('PSD - Denoising 2G');
xlabel('Frequência (Hz)');
ylabel('PSD');
grid on;

% Métricas de comparação
variancia_orig = var(sinal_dados);
energia_orig = sum(sinal_dados.^2);

variancia_1G = var(sinal_1G);
energia_1G = sum(sinal_1G.^2);

variancia_2G = var(sinal_2G);
energia_2G = sum(sinal_2G.^2);

fprintf('\n=== MÉTRICAS DE COMPARAÇÃO ===\n');
fprintf('Sinal Original:\n');
fprintf('  Variância: %.6f\n', variancia_orig);
fprintf('  Energia: %.6f\n', energia_orig);

fprintf('Denoising 1G:\n');
fprintf('  Variância: %.6f (redução: %.2f%%)\n', variancia_1G, (1-variancia_1G/variancia_orig)*100);
fprintf('  Energia: %.6f (redução: %.2f%%)\n', energia_1G, (1-energia_1G/energia_orig)*100);

fprintf('Denoising 2G:\n');
fprintf('  Variância: %.6f (redução: %.2f%%)\n', variancia_2G, (1-variancia_2G/variancia_orig)*100);
fprintf('  Energia: %.6f (redução: %.2f%%)\n', energia_2G, (1-energia_2G/energia_orig)*100);

fprintf('\nProcessamento concluído com sucesso!\n');
