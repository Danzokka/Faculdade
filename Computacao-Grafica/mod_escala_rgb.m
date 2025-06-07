function Y = mod_escala_rgb(X, PH, QH, PV, QV, mascara)

    % Certifique-se de que X é do tipo double para a convolução
    X = double(X);

    % Geração da máscara de convolução
    switch mascara
        case 'triangular'
            hH = (1/PH) * ones(1, PH*2);
            hH = hH / sum(hH); % Normalização
            hV = (1/PV) * ones(PV*2, 1);
            hV = hV / sum(hV); % Normalização
        case 'constante'
            hH = ones(1, PH) / PH;
            hV = ones(PV, 1) / PV;
        otherwise
            error('Tipo de máscara desconhecido');
    end
    
    % Cálculo das novas dimensões após a dilatação e compressão
    colunas = ceil((size(X, 2) * PH) / QH);
    linhas = ceil((size(X, 1) * PV) / QV);

    % Inicialização da imagem de saída Y com as novas dimensões e três canais de cor
    Y = zeros(linhas, colunas, 3);

    % Aplicando o processo para cada canal de cor
    for k = 1:3  % Loop pelos canais de cor da imagem RGB
        
        % Extraia o canal de cor
        X_c = X(:,:,k);
        
        % Dilatação manual horizontal
        X_dilatado_horizontal = zeros(size(X_c, 1), size(X_c, 2) * PH);
        X_dilatado_horizontal(:, 1:PH:end) = X_c;
        
        % Convolução horizontal
        X_convoluido_horizontal = conv2(X_dilatado_horizontal, hH, 'same');
        % Compressão horizontal
        Y_h = X_convoluido_horizontal(:, 1:QH:end);
        
        % Dilatação manual vertical
        Y_dilatado_vertical = zeros(size(Y_h, 1) * PV, size(Y_h, 2));
        Y_dilatado_vertical(1:PV:end, :) = Y_h;
        
        % Convolução vertical
        Y_convoluido_vertical = conv2(Y_dilatado_vertical, hV, 'same');
        % Compressão vertical
        Y_v = Y_convoluido_vertical(1:QV:end, :);
        
        % Recortar ou estender Y_v para garantir que suas dimensões correspondam ao tamanho de Y
        Y_v = Y_v(1:linhas, 1:colunas);
        
        % Atribuir ao canal de cor na imagem de saída
        Y(:,:,k) = Y_v;
    end
    
    % Reajustando os valores para o intervalo de 0 a 255 e convertendo para uint8
    Y = uint8(255 * mat2gray(Y));
end
