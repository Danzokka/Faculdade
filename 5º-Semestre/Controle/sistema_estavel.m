syms s k

% Funções de transferência
Hs = 1;
Gs = 10 / (s^2 * (s+20));

% Função de transferência de malha fechada
T = Gs / (1 + Gs * Hs);

% Obter o numerador e denominador do polinômio característico
[numerador, denominador] = numden(T);

% Montar o polinômio característico
polinomio_caracteristico = simplify(denominador * (1 + k * numerador) - numerador);

% Exibir o polinômio característico
disp('Polinômio característico:');
disp(polinomio_caracteristico);

% Encontrar a condição de estabilidade (parte real dos polos deve ser negativa)
condicao_estabilidade = solve(real(roots(coeffs(polinomio_caracteristico, s))) < 0, k);

% Exibir a condição para estabilidade
disp('Condição para estabilidade:');
disp(condicao_estabilidade);

