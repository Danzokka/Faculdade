% Gerar a imagem fantasma
P = phantom(256);

% Definir os fatores de escala
PH = 3; QH = 2; PV = 4; QV = 5; 

% Aplicar o método de modificação em escala à imagem fantasma
Y_phantom = mod_escala_rgb(repmat(P, [1, 1, 3]), PH, QH, PV, QV, 'triangular');

% Carregar uma imagem natural
img_natural = imread('sapo.png');

% Aplicar o método de modificação em escala à imagem natural
Y_natural = mod_escala_rgb(img_natural, PH, QH, PV, QV, 'triangular');

% Criar uma nova figura para subplots
figure;

% Subplot para a imagem fantasma original
subplot(2, 2, 1);
imshow(P), title('Imagem Phantom Original');

% Subplot para a imagem fantasma modificada em escala
subplot(2, 2, 2);
imshow(Y_phantom), title('Imagem Phantom Modificada');

% Subplot para a imagem natural original
subplot(2, 2, 3);
imshow(img_natural), title('Imagem Natural Original');

% Subplot para a imagem natural modificada em escala
subplot(2, 2, 4);
imshow(Y_natural), title('Imagem Natural Modificada');
