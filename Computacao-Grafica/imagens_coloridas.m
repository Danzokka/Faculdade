largura = 500;
altura = 500;

% Definir os valores RGB para Laranja, Dourado e Marrom
laranja = [255, 140, 0]; % Exemplo de RGB para Laranja
dourado = [218, 165, 32]; % Exemplo de RGB para Dourado
marrom = [150, 75, 0]; % Exemplo de RGB para Marrom

%Inicializando as imagens zeradas do tipo uint8
imagemLaranja = zeros(altura, largura, 3, 'uint8');
imagemDourado = zeros(altura, largura, 3, 'uint8');
imagemMarrom = zeros(altura, largura, 3, 'uint8');

% Criar e preencher as imagens
for i = 1:altura
    for j = 1:largura
          % Preencher a imagem Laranja com o valor RGB para Laranja
        imagemLaranja(i, j, :) = laranja;

        % Preencher a imagem Dourado com o valor RGB para Dourado
        imagemDourado(i, j, :) = dourado;

        % Preencher a imagem Marrom com o valor RGB para Marrom
        imagemMarrom(i, j, :) = marrom;
    end
end

% Mostrar as imagens
figure, imshow(imagemLaranja), title('Imagem Laranja');
figure, imshow(imagemDourado), title('Imagem Dourado');
figure, imshow(imagemMarrom), title('Imagem Marrom');
