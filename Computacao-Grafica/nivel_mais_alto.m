% Ler a imagem RGB
imagem = imread('sapo.png');

% Obter as dimensões da imagem
altura = size(imagem, 1);
largura = size(imagem, 2);

% Criar uma nova imagem (inicialmente vazia) para o resultado
imagemProcessada = zeros(altura, largura, 3, 'uint8');

% Percorrer todos os pixels da imagem
for i = 1:altura
    for j = 1:largura
        % Extrair os valores R, G, B do pixel atual diretamente
        R = imagem(i, j, 1);
        G = imagem(i, j, 2);
        B = imagem(i, j, 3);

        % Determina qual componente tem o valor máximo e zera os outros componentes
        if R >= G && R >= B
            novoPixel = [R, 0, 0];
        elseif G > R && G >= B
            novoPixel = [0, G, 0];
        else
            novoPixel = [0, 0, B];
        end

        % Atribuir o novo valor ao pixel na imagem processada
        imagemProcessada(i, j, :) = novoPixel;
    end
end

% Mostrar a imagem processada
figure, imshow(imagemProcessada), title('Imagem Processada');
