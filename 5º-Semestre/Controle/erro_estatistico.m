syms s A

% Definindo a função de transferência
FTMF = (100 / ((s + 6) * (s + 4)));

% Calculando o erro estático para s tendendo a 0
e_inf = limit((1 + FTMF), s, 0);

% Exibindo o erro estático
e_inf
