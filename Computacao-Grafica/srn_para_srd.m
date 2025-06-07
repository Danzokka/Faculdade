function [i, j] = srn_para_srd(x, y, L, C)
    % Conversão de coordenadas SRN (x, y) para SRD (i, j)
    % (x, y) ∈ [-1, 1] x [-1, 1]
    % (i, j) ∈ [1, L] x [1, C]
    
    % Conversão de x para j
    j = round((x + 1) * (C - 1) / 2 + 1);
    
    % Conversão de y para i
    i = round((1 - y) * (L - 1) / 2 + 1);
end
