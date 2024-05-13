function img = desenha_linha(i0, j0, ifinal, jfinal, M, N, img)
    % Arredonda as coordenadas de partida, mantém as finais flutuantes
    i0 = round(i0);
    j0 = round(j0);
    ifinal = round(ifinal);
    jfinal = round(jfinal);

    steep = abs(jfinal - j0) > abs(ifinal - i0);

    if steep
        [i0, j0] = deal(j0, i0);
        [ifinal, jfinal] = deal(jfinal, ifinal);
    end

    if i0 > ifinal
        [i0, ifinal] = deal(ifinal, i0);
        [j0, jfinal] = deal(jfinal, j0);
    end

    di = ifinal - i0;
    dj = abs(jfinal - j0);
    error = di / 2;
    y = j0;

    if j0 < jfinal
        ystep = 1;
    else
        ystep = -1;
    end

    for x = i0:ifinal
        if steep
            img(y, x) = 1;
        else
            img(x, y) = 1;
        end
        error = error - dj;
        if error < 0
            y = y + ystep;
            error = error + di;
        end
    end
end