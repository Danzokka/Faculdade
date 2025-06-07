function linha()
    % Solicita as coordenadas ao usuário
    x1 = input('Digite o valor de x1: ');
    y1 = input('Digite o valor de y1: ');
    x2 = input('Digite o valor de x2: ');
    y2 = input('Digite o valor de y2: ');
    M = input('Digite o valor de M (altura da matriz): ');
    N = input('Digite o valor de N (largura da matriz): ');

    % Inicializa a matriz
    X = zeros(M, N);

    % Define o número de pontos intermediários
    numPontos = max(abs(x2 - x1), abs(y2 - y1));

    for k = 0:numPontos
        tk = k / numPontos;
        % Interpolação linear
        x = round((1 - tk) * x1 + tk * x2);
        y = round((1 - tk) * y1 + tk * y2);
        
        % Verifica se o ponto está dentro dos limites da matriz
        if x >= 1 && x <= N && y >= 1 && y <= M
            X(y, x) = 255; % Marca o ponto na matriz
        end
    end

    % Mostra a matriz resultante
    imshow(X, []);
end
