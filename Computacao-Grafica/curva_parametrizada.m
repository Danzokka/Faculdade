function curva_parametrizada()
    % Dimensões da matriz de representação (imagem)
    L = 200; % linhas
    C = 200; % colunas
    
    % Criar uma matriz para a representação da imagem
    img = zeros(L, C);
    
    % Número de pontos na curva
    N = 5000;
    t = linspace(0, 1, N);
    
    % Gerar os pontos da curva
    x = cos(2 * pi * t);
    y = sin(2 * pi * t);
    
    % Converter cada ponto para coordenadas de matriz e desenhar
    for k = 1:N
        [i, j] = srn_para_srd(x(k), y(k), L, C);
        if i >= 1 && i <= L && j >= 1 && j <= C
            img(i, j) = 1; % Marcando o pixel
        end
    end
    
    % Mostrar a imagem
    imshow(img);
    title('Curva Parametrizada no Plano');
end