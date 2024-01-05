% Definindo a função de transferência G(s)
numerator_G = [1 1]; % k * (s + 1)
denominator_G = conv([1 -1], conv([1 4], [1 8])); % (s - 1) * (s + 4) * (s + 8)
G = tf(numerator_G, denominator_G);

% Definindo a função de transferência H(s)
H = tf(1, 1); % H(s) = 1

% Calculando a função de transferência de malha fechada
T = feedback(G, H);

% Plotando o Lugar das Raízes
% rlocus(T);
s = -1.13 - 1.43i;

K = (abs(s) * abs(s - 1) * abs(s + 4) * abs(s + 8)) / (abs(s + 1) * abs(s + 3));
display(K);



