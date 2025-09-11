% Atividade Completa: Transformada de Wavelets para Suavização de Sinal
% Arquivo principal que executa todas as questões da atividade

clear; clc; close all;

fprintf('=== ATIVIDADE COMPLETA: TRANSFORMADA DE WAVELETS ===\n\n');

% Questões 1-4: Sequência básica
fprintf('Executando Questões 1-4: Sequência básica da atividade...\n');
run('main_atividade.m');

% Questão 6: Diferentes valores de Ind
fprintf('\nExecutando Questão 6: Teste com diferentes valores de Ind...\n');
run('questao6_diferentes_ind.m');

% Questão 8: Ruído forte
fprintf('\nExecutando Questão 8: Teste com ruído forte (A=0.3)...\n');
run('questao8_ruido_forte.m');

% Questão 10: Comparação entre ruídos
fprintf('\nExecutando Questão 10: Comparação entre diferentes ruídos...\n');
run('questao10_comparacao_ruidos.m');

% Questão 11: Análise completa
fprintf('\nExecutando Questão 11: Análise completa com diferentes parâmetros...\n');
run('questao11_analise_completa.m');

fprintf('\n=== ATIVIDADE COMPLETA FINALIZADA ===\n');
fprintf('Todas as questões foram executadas e os gráficos gerados.\n');
fprintf('Consulte o README.md para as respostas teóricas detalhadas.\n');
