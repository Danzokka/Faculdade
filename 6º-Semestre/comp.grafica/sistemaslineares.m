% Definindo os valores de h[n]
n = 0:4; % Valores de n de 0 a 4
h = [5, 0, 20, 0, 80]; % Coeficientes de h[n]

% Criando o gráfico de hastes
stem(n, h, 'filled');

% Configurando o gráfico
title('Resposta ao Impulso h[n]');
xlabel('n');
ylabel('h[n]');
grid on;

% Exibindo os valores sobre os pontos
for i = 1:length(n)
    text(n(i), h(i), num2str(h(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
