% Atividade: Transformada de Wavelets para Suavização de Sinal
% Etapa 3: Filtragem com Wavelets

% Carrega variáveis das etapas anteriores (se executado separadamente)
if ~exist('x_ruidoso', 'var')
    run('etapa2_adicionar_ruido.m');
end

% Decomposição wavelet
N = 5;  % Número de níveis de decomposição
wavelet_name = 'db4';  % Tipo de wavelet (Daubechies 4)

% Realizar decomposição wavelet
[C, L] = wavedec(x_ruidoso, N, wavelet_name);

% Plotagem dos coeficientes
figure(4);
plot(C);
title('Coeficientes da Decomposição Wavelet');
xlabel('Índice');
ylabel('Amplitude');
grid on;

% Separação dos coeficientes
Y = C;  % Cópia dos coeficientes para processamento

% Definir índices para zerar coeficientes de alta frequência
% Os primeiros coeficientes são de aproximação (baixa frequência)
% Os últimos são de detalhe (alta frequência)
Ind = 35;  % Índice a partir do qual zerar coeficientes
Y(Ind:end) = 0;  % Zerar coeficientes de detalhe (alta frequência)

% Reconstrução do sinal filtrado
y = waverec(Y, L, wavelet_name);

fprintf('Decomposição wavelet realizada com:\n');
fprintf('- Wavelet: %s\n', wavelet_name);
fprintf('- Níveis de decomposição: %d\n', N);
fprintf('- Coeficientes zerados a partir do índice: %d\n', Ind);
