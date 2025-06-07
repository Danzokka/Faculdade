function pendulo(i0, j0, theta0, g, l, tempos, M, N)
    theta0 = deg2rad(theta0);  % Converter ângulo inicial para radianos

    output_folder = 'pendulo';
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end
    
    for idx = 1:length(tempos)
        t = tempos(idx);
        theta = theta0 * cos(sqrt(g / l) * t);
        
        % Calcular as coordenadas finais
        x_end = i0 + l * sin(theta);
        y_end = j0 + l * cos(theta);
        
        img = zeros(M, N);
        
        % Primeiro desenhe o círculo no ponto final
        img = desenha_circulo(x_end, y_end, 5, M, N, img);
        
        % Depois desenhe a linha conectando ao centro do círculo
        img = desenha_linha(i0, j0, x_end, y_end, M, N, img);
        
        figure;
        imshow(img);
        title(sprintf('Tempo = %.2f s', t));
        
        filename = fullfile(output_folder, sprintf('frame_pendulo_%03d.png', idx));
        imwrite(img, filename);
        pause(0.1);
    end
end
