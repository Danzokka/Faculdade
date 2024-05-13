% Exemplo de uso das funções
L = 10; % número de linhas na matriz
C = 10; % número de colunas na matriz

% Coordenadas no SRN
x = 1;
y = -1;

[i, j] = srn_para_srd(x, y, L, C);
fprintf('De SRN (%f, %f) para SRD (%d, %d)\n', x, y, i, j);

% Coordenadas no SRD
i = 10;
j = 10;

[x, y] = srd_para_srn(i, j, L, C);
fprintf('De SRD (%d, %d) para SRN (%f, %f)\n', i, j, x, y);
