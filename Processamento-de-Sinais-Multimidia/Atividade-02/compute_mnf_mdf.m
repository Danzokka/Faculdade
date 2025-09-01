function [MNF, MDF] = compute_mnf_mdf(S, f)
%COMPUTE_MNF_MDF Calcula a Frequência Média (MNF) e Frequência Mediana (MDF)
%
% Entradas:
%   S - densidade espectral de potência (vetor coluna)
%   f - vetor de frequências correspondente
%
% Saídas:
%   MNF - Frequência Média (Mean Frequency)
%   MDF - Frequência Mediana (Median Frequency)

arguments
    S (:,1) double {mustBeNonnegative}
    f (:,1) double {mustBeNonnegative}
end

% Verificar se os vetores têm o mesmo tamanho
if length(S) ~= length(f)
    error('Os vetores S e f devem ter o mesmo comprimento.');
end

% Garantir que S seja positivo (evitar divisão por zero)
S = max(S, eps);

% Calcular a potência total
P_total = sum(S);

if P_total <= 0
    warning('Potência total do sinal é zero ou negativa. Retornando NaN.');
    MNF = NaN;
    MDF = NaN;
    return;
end

%% Cálculo da Frequência Média (MNF)
% MNF = (Σ f_k * S_k) / (Σ S_k)
MNF = sum(f .* S) / P_total;

%% Cálculo da Frequência Mediana (MDF)
% MDF é a frequência onde metade da potência está abaixo e metade acima
% Encontrar o índice onde a potência acumulada atinge 50% da potência total

% Potência acumulada
P_cum = cumsum(S);

% Encontrar o índice onde P_cum >= P_total/2
idx_median = find(P_cum >= P_total/2, 1, 'first');

if isempty(idx_median)
    % Caso extremo - usar a última frequência
    MDF = f(end);
else
    % Interpolação linear para maior precisão
    if idx_median == 1
        MDF = f(1);
    else
        % Interpolação entre os pontos idx_median-1 e idx_median
        f1 = f(idx_median-1);
        f2 = f(idx_median);
        P1 = P_cum(idx_median-1);
        P2 = P_cum(idx_median);
        P_target = P_total/2;
        
        % Interpolação linear: MDF = f1 + (f2-f1) * (P_target-P1)/(P2-P1)
        if P2 > P1
            MDF = f1 + (f2 - f1) * (P_target - P1) / (P2 - P1);
        else
            MDF = f1;
        end
    end
end

% Verificar se os resultados são válidos
if ~isfinite(MNF) || MNF < 0
    warning('MNF calculada inválida. Verifique os dados de entrada.');
    MNF = NaN;
end

if ~isfinite(MDF) || MDF < 0
    warning('MDF calculada inválida. Verifique os dados de entrada.');
    MDF = NaN;
end

end