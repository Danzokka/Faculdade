function triangulo()
    % Solicita as coordenadas dos vértices ao usuário
    v1 = input('Digite as coordenadas do vértice v1 no formato [x1, y1]: ');
    v2 = input('Digite as coordenadas do vértice v2 no formato [x2, y2]: ');
    v3 = input('Digite as coordenadas do vértice v3 no formato [x3, y3]: ');
    M = input('Digite o valor de M (altura da matriz): ');
    N = input('Digite o valor de N (largura da matriz): ');

    % Inicializa a matriz
    X = zeros(M, N);

    % Chama a função linha para cada aresta do triângulo
    X = linha(v1, v2, M, N, X);
    X = linha(v2, v3, M, N, X);
    X = linha(v3, v1, M, N, X);

    % Mostra a matriz resultante
    imshow(X, []);

    % Função para rasterizar uma linha entre dois pontos
    function X = linha(p1, p2, M, N, X)
        numPontos = max(abs(p2(1) - p1(1)), abs(p2(2) - p1(2)));
        for k = 0:numPontos
            tk = k / numPontos;
            x = round((1 - tk) * p1(1) + tk * p2(1));
            y = round((1 - tk) * p1(2) + tk * p2(2));
            if x >= 1 && x <= N && y >= 1 && y <= M
                X(y, x) = 255;
            end
        end
    end
end
