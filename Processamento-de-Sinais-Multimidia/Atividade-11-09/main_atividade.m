% Atividade: Transformada de Wavelets para Suavização de Sinal
% Arquivo principal que executa todas as etapas

clear; clc; close all;

fprintf('=== ATIVIDADE: TRANSFORMADA DE WAVELETS PARA SUAVIZAÇÃO ===\n\n');

% Etapa 1: Criação do sinal original
fprintf('Executando Etapa 1: Criação do sinal original...\n');
run('etapa1_sinal_original.m');

% Etapa 2: Adição de ruído
fprintf('\nExecutando Etapa 2: Adição de ruído...\n');
run('etapa2_adicionar_ruido.m');

% Etapa 3: Filtragem com wavelets
fprintf('\nExecutando Etapa 3: Filtragem com wavelets...\n');
run('etapa3_filtragem_wavelet.m');

% Etapa 4: Visualização dos resultados
fprintf('\nExecutando Etapa 4: Visualização dos resultados...\n');
run('etapa4_visualizacao_resultados.m');

fprintf('\n=== ATIVIDADE CONCLUÍDA ===\n');
fprintf('Todos os gráficos foram gerados e os resultados exibidos.\n');
