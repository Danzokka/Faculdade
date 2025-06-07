function img = desenha_circulo(i0, j0, R, M, N, img)
    % Arredonda o centro para garantir precisão visual
    i0 = round(i0);
    j0 = round(j0);
    for i = max(1, i0 - R):min(M, i0 + R)
        dy = abs(i - i0);
        dx = round(sqrt(R^2 - dy^2));
        j1 = max(1, j0 - dx);
        j2 = min(N, j0 + dx);
        img(i, j1:j2) = 1;
    end
end
