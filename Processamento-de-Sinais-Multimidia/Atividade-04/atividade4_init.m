% Atividade 4 - Denoising de 2ª Geração
% Implementação do método de denoising usando DWT

clear; clc; close all;

% Carregamento do arquivo .mat
load('sinais.mat');

% Verificação das variáveis disponíveis no arquivo
fprintf('=== ATIVIDADE 4: DENOISING DE 2ª GERAÇÃO ===\n\n');
fprintf('Variáveis carregadas do arquivo sinais.mat:\n');
whos

% Seleção do sinal para processamento
% Assumindo que existe uma variável 'sinal' ou similar no arquivo .mat
if exist('x', 'var')
    sinal_original = x;
    fprintf('\nSinal ''x'' selecionado para processamento.\n');
elseif exist('sinal', 'var')
    sinal_original = sinal;
    fprintf('\nSinal ''sinal'' selecionado para processamento.\n');
else
    % Criar um sinal de exemplo se não houver no .mat
    fs = 1000;
    t = 0:1/fs:1-1/fs;
    sinal_original = sin(2*pi*50*t) + 0.5*sin(2*pi*120*t);
    fprintf('\nSinal sintético criado para demonstração.\n');
end

% Adição de ruído ao sinal (se necessário)
if ~exist('ruido', 'var')
    ruido = 0.2 * randn(size(sinal_original));
end
sinal_ruidoso = sinal_original + ruido;

% Plotagem dos sinais iniciais
figure(1);
subplot(3,1,1);
plot(sinal_original);
title('Sinal Original');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(sinal_ruidoso);
title('Sinal com Ruído');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(ruido);
title('Ruído Adicionado');
xlabel('Amostras');
ylabel('Amplitude');
grid on;

fprintf('\nConfigurações iniciais concluídas.\n');
fprintf('Sinal original: %d amostras\n', length(sinal_original));
fprintf('Ruído adicionado com desvio padrão: %.3f\n', std(ruido));
