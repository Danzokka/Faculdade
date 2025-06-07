function Y = mod_escala_cinza(X, PH, QH, PV, QV, mascara)

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
    
    % Dilatação manual horizontal
    X_dilatado_horizontal = zeros(size(X, 1), size(X, 2) * PH);
    X_dilatado_horizontal(:, 1:PH:end) = X;
    
    % Convolução horizontal
    X_convoluido_horizontal = conv2(X_dilatado_horizontal, hH, 'same');
    % Compressão horizontal
    Y_h = X_convoluido_horizontal(:, 1:QH:end);
    
    % Dilatação manual vertical
    Y_dilatado_vertical = zeros(size(Y_h, 1) * PV, size(Y_h, 2));
    Y_dilatado_vertical(1:PV:end, :) = Y_h;
    
    % Convolução vertical
    Y_convoluido_vertical = conv2(Y_dilatado_v, hV, 'same');
    % Compressão vertical
    Y = Y_convoluido_vertical(1:QV:end, :);
    
    % Reajustando os valores para o intervalo de 0 a 255 e convertendo para uint8
    Y = uint8(255 * mat2gray(Y));
end
