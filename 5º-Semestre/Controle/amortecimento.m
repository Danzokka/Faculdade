% Definindo o Sobressinal Máximo Percentual (Mp)
Mp = 7; % Por exemplo, para um sobressinal de 7%

% Calculando o coeficiente de amortecimento (zeta)
zeta = -log(Mp/100) / sqrt(pi^2 + (log(Mp/100))^2);

% Arredondando o valor de zeta para duas casas decimais
zeta


