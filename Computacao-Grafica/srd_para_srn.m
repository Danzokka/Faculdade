function [x, y] = srd_para_srn(i, j, L, C)
    % Conversão de coordenadas SRD (i, j) para SRN (x, y)
    % (i, j) ∈ [1, L] x [1, C]
    % (x, y) ∈ [-1, 1] x [-1, 1]
    
    % Conversão de j para x
    x = 2 * (j - 1) / (C - 1) - 1;
    
    % Conversão de i para y
    y = 1 - 2 * (i - 1) / (L - 1);
end
