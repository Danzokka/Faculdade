% Atividade 4 - Exemplo Específico do Documento
% Implementação do exemplo com k=3 e sequência [10 15 20 25 30 40 45 50 55 60]

clear; clc; close all;

fprintf('=== EXEMPLO ESPECÍFICO DO DOCUMENTO ===\n\n');

% Exemplo da sequência apresentada no documento
x_exemplo = [10 15 20 25 30 40 45 50 55 60];
fprintf('Sequência original: [%s]\n', num2str(x_exemplo));

% Aplicação do deslocamento circular k=3
k = 3;
x_deslocado = circshift(x_exemplo, k);
fprintf('Após deslocamento k=%d: [%s]\n', k, num2str(x_deslocado));

% Verificação: o resultado deve ser [50 55 60 10 15 20 25 30 40 45]
x_esperado = [50 55 60 10 15 20 25 30 40 45];
fprintf('Resultado esperado: [%s]\n', num2str(x_esperado));

if isequal(x_deslocado, x_esperado)
    fprintf('✓ Deslocamento circular implementado corretamente!\n\n');
else
    fprintf('✗ Erro na implementação do deslocamento circular!\n\n');
end

% Implementação completa do denoising 2G usando sinais do arquivo .mat
fprintf('=== IMPLEMENTAÇÃO COMPLETA COM SINAIS.MAT ===\n');

% Carregar dados do arquivo .mat
try
    load('sinais.mat');
    fprintf('Arquivo sinais.mat carregado com sucesso.\n');
    
    % Verificar variáveis disponíveis
    vars = who;
    fprintf('Variáveis disponíveis: %s\n', strjoin(vars, ', '));
    
    % Selecionar primeira variável numérica como sinal de exemplo
    sinal_selecionado = [];
    nome_sinal = '';
    
    for i = 1:length(vars)
        var_atual = eval(vars{i});
        if isnumeric(var_atual) && isvector(var_atual) && length(var_atual) > 50
            sinal_selecionado = var_atual(:)'; % Garantir vetor linha
            nome_sinal = vars{i};
            break;
        end
    end
    
    if isempty(sinal_selecionado)
        error('Nenhum sinal adequado encontrado no arquivo .mat');
    end
    
    fprintf('Sinal selecionado: %s (comprimento: %d)\n', nome_sinal, length(sinal_selecionado));
    
catch ME
    fprintf('Erro ao carregar arquivo: %s\n', ME.message);
    fprintf('Usando sinal sintético...\n');
    
    % Criar sinal sintético para demonstração
    t = 0:0.01:4*pi;
    sinal_limpo = sin(t) + 0.5*sin(3*t);
    ruido = 0.3*randn(size(t));
    sinal_selecionado = sinal_limpo + ruido;
    nome_sinal = 'sinal_sintetico';
end

% Parâmetros do denoising
fprintf('\n=== PARÂMETROS DO DENOISING ===\n');
wavelet_name = 'db4';
niveis = min(6, floor(log2(length(sinal_selecionado))));
k_values = [0, 1, 2, 3];  % Seguindo o exemplo do documento

fprintf('Wavelet: %s\n', wavelet_name);
fprintf('Níveis de decomposição: %d\n', niveis);
fprintf('Deslocamentos k: [%s]\n', num2str(k_values));

% Estimativa do threshold
[C_temp, L_temp] = wavedec(sinal_selecionado, niveis, wavelet_name);
detalhe_nivel1 = detcoef(C_temp, L_temp, 1);
sigma_estimado = median(abs(detalhe_nivel1)) / 0.6745;
threshold = sigma_estimado * sqrt(2 * log(length(sinal_selecionado)));

fprintf('Sigma estimado: %.6f\n', sigma_estimado);
fprintf('Threshold calculado: %.6f\n', threshold);

% Aplicação do denoising 1G (método tradicional)
fprintf('\n=== DENOISING 1ª GERAÇÃO ===\n');
[C_1G, L_1G] = wavedec(sinal_selecionado, niveis, wavelet_name);
C_1G_th = wthresh(C_1G, 's', threshold);
sinal_1G = waverec(C_1G_th, L_1G, wavelet_name);

% Aplicação do denoising 2G (método com deslocamentos)
fprintf('=== DENOISING 2ª GERAÇÃO ===\n');
sinais_processados = zeros(length(k_values), length(sinal_selecionado));

for i = 1:length(k_values)
    k = k_values(i);
    fprintf('Processando deslocamento k=%d...\n', k);
    
    % Passo 1: Deslocamento circular
    if k == 0
        sinal_deslocado = sinal_selecionado;
    else
        sinal_deslocado = circshift(sinal_selecionado, k);
    end
    
    % Passo 2: Decomposição wavelet
    [C_k, L_k] = wavedec(sinal_deslocado, niveis, wavelet_name);
    
    % Passo 3: Aplicação do threshold
    C_k_th = wthresh(C_k, 's', threshold);
    
    % Passo 4: Reconstrução
    sinal_reconstruido = waverec(C_k_th, L_k, wavelet_name);
    
    % Passo 5: Deslocamento inverso
    if k == 0
        sinal_final = sinal_reconstruido;
    else
        sinal_final = circshift(sinal_reconstruido, -k);
    end
    
    % Armazenar resultado
    sinais_processados(i, :) = sinal_final;
end

% Passo 6: Média das versões processadas
sinal_2G = mean(sinais_processados, 1);

fprintf('Denoising 2G concluído - média de %d versões calculada.\n', length(k_values));

% Cálculo de métricas de desempenho
fprintf('\n=== MÉTRICAS DE DESEMPENHO ===\n');

% Variâncias
var_original = var(sinal_selecionado);
var_1G = var(sinal_1G);
var_2G = var(sinal_2G);

fprintf('Variância do sinal original: %.6f\n', var_original);
fprintf('Variância após 1G: %.6f (redução: %.2f%%)\n', var_1G, (1-var_1G/var_original)*100);
fprintf('Variância após 2G: %.6f (redução: %.2f%%)\n', var_2G, (1-var_2G/var_original)*100);

% Energia dos sinais
energia_original = sum(sinal_selecionado.^2);
energia_1G = sum(sinal_1G.^2);
energia_2G = sum(sinal_2G.^2);

fprintf('\nEnergia do sinal original: %.6f\n', energia_original);
fprintf('Energia após 1G: %.6f (variação: %.2f%%)\n', energia_1G, (energia_1G/energia_original-1)*100);
fprintf('Energia após 2G: %.6f (variação: %.2f%%)\n', energia_2G, (energia_2G/energia_original-1)*100);

% Visualização dos resultados
fprintf('\n=== GERAÇÃO DE GRÁFICOS ===\n');

% Gráfico 1: Comparação dos sinais
figure(1);
subplot(3,1,1);
plot(sinal_selecionado, 'b-', 'LineWidth', 1);
title(sprintf('Sinal Original: %s', nome_sinal));
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(sinal_1G, 'r-', 'LineWidth', 1.2);
title('Resultado Denoising 1ª Geração');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(sinal_2G, 'g-', 'LineWidth', 1.2);
title('Resultado Denoising 2ª Geração');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

% Gráfico 2: Comparação direta
figure(2);
plot(sinal_selecionado, 'b-', 'LineWidth', 1, 'DisplayName', 'Original');
hold on;
plot(sinal_1G, 'r-', 'LineWidth', 1.2, 'DisplayName', '1ª Geração');
plot(sinal_2G, 'g-', 'LineWidth', 1.2, 'DisplayName', '2ª Geração');
title('Comparação dos Métodos de Denoising');
xlabel('Amostras');
ylabel('Amplitude');
legend('show', 'Location', 'best');
grid on;
hold off;

% Gráfico 3: Versões intermediárias do 2G
figure(3);
for i = 1:length(k_values)
    subplot(length(k_values), 1, i);
    plot(sinais_processados(i, :), 'LineWidth', 1);
    title(sprintf('Versão Processada com k=%d', k_values(i)));
    xlabel('Amostras');
    ylabel('Amplitude');
    grid on;
end

% Gráfico 4: Diferenças entre métodos
figure(4);
diferenca_1G = sinal_selecionado - sinal_1G;
diferenca_2G = sinal_selecionado - sinal_2G;

subplot(2,1,1);
plot(diferenca_1G, 'r-', 'LineWidth', 1);
title('Diferença: Original - 1ª Geração');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(diferenca_2G, 'g-', 'LineWidth', 1);
title('Diferença: Original - 2ª Geração');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

fprintf('Gráficos gerados com sucesso!\n');

% Salvar resultados em estrutura
resultados.sinal_original = sinal_selecionado;
resultados.sinal_1G = sinal_1G;
resultados.sinal_2G = sinal_2G;
resultados.sinais_intermediarios = sinais_processados;
resultados.parametros.wavelet = wavelet_name;
resultados.parametros.niveis = niveis;
resultados.parametros.k_values = k_values;
resultados.parametros.threshold = threshold;
resultados.metricas.var_original = var_original;
resultados.metricas.var_1G = var_1G;
resultados.metricas.var_2G = var_2G;

fprintf('\n=== PROCESSAMENTO CONCLUÍDO ===\n');
fprintf('Todos os resultados foram calculados e visualizados.\n');
fprintf('Estrutura "resultados" criada com todos os dados.\n');
