% Atividade: Teste com diferentes valores de Ind para diferentes amplitudes
% Questão 11: Repetir procedimento de filtragem com Ind = 50, 40, 30, 20, 10

% Carrega sinal original
if ~exist('x', 'var')
    run('etapa1_sinal_original.m');
end

% Valores de Ind para testar
ind_values = [50, 40, 30, 20, 10];
N = 5;
wavelet_name = 'db4';

% Testa com ruído baixo (A = 0.1)
A1 = 0.1;
ruido1 = A1 * randn(size(x));
x_ruidoso1 = x + ruido1;
[C1, L1] = wavedec(x_ruidoso1, N, wavelet_name);

% Testa com ruído forte (A = 0.3)
A2 = 0.3;
ruido2 = A2 * randn(size(x));
x_ruidoso2 = x + ruido2;
[C2, L2] = wavedec(x_ruidoso2, N, wavelet_name);

fprintf('=== TESTE COMPLETO COM DIFERENTES VALORES DE Ind ===\n\n');

% Teste para ruído baixo
figure(10);
for i = 1:length(ind_values)
    Ind = ind_values(i);
    
    % Filtragem com ruído baixo
    Y1 = C1;
    Y1(Ind:end) = 0;
    y_filtrado1 = waverec(Y1, L1, wavelet_name);
    
    subplot(3, 2, i);
    plot(t, x_ruidoso1, 'b-', 'LineWidth', 0.8);
    hold on;
    plot(t, y_filtrado1, 'r-', 'LineWidth', 1.5);
    plot(t, x, 'g--', 'LineWidth', 1);
    title(sprintf('Ruído Baixo - Ind = %d', Ind));
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    legend('Ruidoso', 'Filtrado', 'Original', 'Location', 'best');
    grid on;
    hold off;
    
    % Métricas
    mse1 = mean((x - y_filtrado1).^2);
    snr1 = 10*log10(var(x)/var(y_filtrado1 - x));
    
    fprintf('RUÍDO BAIXO (A=0.1) - Ind = %d:\n', Ind);
    fprintf('  MSE: %.6f | SNR: %.2f dB\n', mse1, snr1);
    fprintf('  Coeficientes preservados: %d/%d (%.1f%%)\n\n', ...
            Ind-1, length(C1), ((Ind-1)/length(C1))*100);
end
sgtitle('Filtragem com Ruído Baixo (A = 0.1) - Diferentes Valores de Ind');

% Teste para ruído forte
figure(11);
for i = 1:length(ind_values)
    Ind = ind_values(i);
    
    % Filtragem com ruído forte
    Y2 = C2;
    Y2(Ind:end) = 0;
    y_filtrado2 = waverec(Y2, L2, wavelet_name);
    
    subplot(3, 2, i);
    plot(t, x_ruidoso2, 'b-', 'LineWidth', 0.8);
    hold on;
    plot(t, y_filtrado2, 'r-', 'LineWidth', 1.5);
    plot(t, x, 'g--', 'LineWidth', 1);
    title(sprintf('Ruído Forte - Ind = %d', Ind));
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    legend('Ruidoso', 'Filtrado', 'Original', 'Location', 'best');
    grid on;
    hold off;
    
    % Métricas
    mse2 = mean((x - y_filtrado2).^2);
    snr2 = 10*log10(var(x)/var(y_filtrado2 - x));
    
    fprintf('RUÍDO FORTE (A=0.3) - Ind = %d:\n', Ind);
    fprintf('  MSE: %.6f | SNR: %.2f dB\n', mse2, snr2);
    fprintf('  Coeficientes preservados: %d/%d (%.1f%%)\n\n', ...
            Ind-1, length(C2), ((Ind-1)/length(C2))*100);
end
sgtitle('Filtragem com Ruído Forte (A = 0.3) - Diferentes Valores de Ind');
