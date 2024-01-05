% Coeficientes de G(s)
Gs_numerador = [100];
Gs_denominador = conv([1 4], [1 6]); % convolução para multiplicação dos polinômios

% Coeficientes de H(s)
Hs_numerador = [1];
Hs_denominador = [1];
%Hs_denominador = [0 1]; s é representado como [0 1] no domínio de Laplace caso fosse degrau unitário


% Criando as funções de transferência de G(s) e H(s)
Gs = tf(Gs_numerador, Gs_denominador);
Hs = tf(Hs_numerador, Hs_denominador);

% Calculando a função de transferência de malha fechada
T = feedback(Gs, Hs);

% Calculando os coeficientes da função de transferência de malha fechada
[num, den] = tfdata(T, 'v');

% Encontrar os parâmetros do sistema de segunda ordem
omega_n = sqrt(den(3));
zeta = 10 / (2 * omega_n);

% Calcular o sobressinal (%OS)
OS_percent = exp(-zeta * pi / sqrt(1 - zeta^2)) * 100;

% Exibir o valor do sobressinal
disp(['O sobressinal é de ', num2str(OS_percent), '%']);
