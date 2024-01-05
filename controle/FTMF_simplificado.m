syms s k

% Funções de transferência
Hs = 1;
Gs = 10 / ((s+4) * (s + 6));

% Função de transferência de malha fechada
T = Gs / (1 + Gs * Hs);

% Simplificar a expressão
T = simplify(T);

% Exibir a função de transferência de malha fechada
T

