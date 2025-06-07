% Definindo os valores de K para avaliação
K_values = linspace(0,1000);

% Inicializando um vetor para armazenar os valores estáveis de K
stable_K = [];

% Verificando a estabilidade para cada valor de K
for i = 1:length(K_values)
    K_val = K_values(i);
    denom = [1, 20, 10*K_val, 10]; % Coeficientes do polinômio característico

    % Verificando se o polinômio é um polinômio de Hurwitz
    if all(real(roots(denom))<0)
        stable_K = [stable_K K_val];
    end
end

% Exibindo o intervalo de valores de K para os quais o sistema é estável
disp(['O sistema é estável para K entre ', num2str(min(stable_K)), ' e ', num2str(max(stable_K))]);

