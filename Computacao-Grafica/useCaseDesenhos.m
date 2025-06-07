M = 100;  % linhas
N = 100;  % colunas
img_linha = desenha_linha(10, 10, 90, 90, M, N);
img_circulo = desenha_circulo(50, 50, 30, M, N);

figure;
subplot(1,2,1), imshow(img_linha), title('Segmento de Reta');
subplot(1,2,2), imshow(img_circulo), title('Círculo Preenchido');
