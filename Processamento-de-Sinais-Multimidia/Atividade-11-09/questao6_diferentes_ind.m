% Atividade: Teste com diferentes valores de Ind
% Questão 6: Repetir procedimento alterando valores de Ind

% Carrega variáveis das etapas anteriores
if ~exist('x_ruidoso', 'var')
    run('etapa2_adicionar_ruido.m');
end

% Valores de Ind para testar
ind_values = [50, 40, 30, 20, 10];
N = 5;  % Número de níveis de decomposição
wavelet_name = 'db4';  % Tipo de wavelet

% Decomposição wavelet (uma vez só)
[C, L] = wavedec(x_ruidoso, N, wavelet_name);

fprintf('=== TESTE COM DIFERENTES VALORES DE Ind ===\n\n');

figure(7);
for i = 1:length(ind_values)
    Ind = ind_values(i);
    
    % Cópia dos coeficientes
    Y = C;
    
    % Zerar coeficientes a partir do índice Ind
    Y(Ind:end) = 0;
    
    % Reconstrução do sinal
    y_filtered = waverec(Y, L, wavelet_name);
    
    % Plotagem
    subplot(3, 2, i);
    plot(t, x_ruidoso, 'b-', 'LineWidth', 0.8);
    hold on;
    plot(t, y_filtered, 'r-', 'LineWidth', 1.5);
    plot(t, x, 'g--', 'LineWidth', 1);
    title(sprintf('Ind = %d', Ind));
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    legend('Ruidoso', 'Filtrado', 'Original', 'Location', 'best');
    grid on;
    hold off;
    
    % Cálculo de métricas
    mse = mean((x - y_filtered).^2);
    snr = 10*log10(var(x)/var(y_filtered - x));
    
    fprintf('Ind = %d:\n', Ind);
    fprintf('  MSE: %.6f\n', mse);
    fprintf('  SNR: %.2f dB\n', snr);
    fprintf('  Coeficientes preservados: %d/%d (%.1f%%)\n\n', ...
            Ind-1, length(C), ((Ind-1)/length(C))*100);
end

sgtitle('Comparação de Filtragem com Diferentes Valores de Ind');
