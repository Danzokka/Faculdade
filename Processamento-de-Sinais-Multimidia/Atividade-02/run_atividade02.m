%% Atividade 02 - Processamento de Sinais Multimídia
% Métodos de Bartlett e Welch para estimativa de MNF e MDF
% Parte 2: Análise Espectral
% Data: %s
% -------------------------------------------------------------------------
% Este script demonstra o uso dos métodos de Bartlett e Welch para:
%   1) Sinal aleatório limitado em frequência
%   2) Sinal contendo notas musicais
%   3) Sinal de voz
% Calcula MNF e MDF para cada método e compara com valores "reais"

fprintf('=== Atividade 02 - Análise Espectral ===\n');
fprintf('Iniciando análise (%s)\n\n', datestr(now));

%% Parâmetros de configuração
segment_ms = 40;        % duração da janela (ms)
overlap_pct = 50;       % overlap para Welch (%)
windowType = 'hann';    % tipo de janela

%% Gerar sinais de teste
fprintf('Gerando sinais de teste...\n');
[x_noise, x_music, x_voice, fs] = generate_test_signals();

% Array com os sinais e suas descrições
signals = {x_noise, x_music, x_voice};
signal_names = {'Ruído Filtrado', 'Música', 'Voz'};
signal_files = {'noise', 'music', 'voice'};

%% Inicializar estruturas para armazenar resultados
results = struct();

%% Análise para cada sinal
for sig_idx = 1:length(signals)
    x = signals{sig_idx};
    sig_name = signal_names{sig_idx};
    sig_file = signal_files{sig_idx};
    
    fprintf('\n--- Analisando %s ---\n', sig_name);
    
    %% 1. Valores "reais" (sinal completo)
    fprintf('Calculando valores de referência (sinal completo)...\n');
    
    % FFT do sinal completo
    N = length(x);
    Nfft = 2^nextpow2(N);
    X_full = fft(x, Nfft);
    
    % Espectro unilateral
    K = Nfft/2 + 1;
    S_real = abs(X_full(1:K)).^2 / (fs * N);
    S_real(2:end-1) = 2 * S_real(2:end-1);
    f_real = (0:K-1)' * fs / Nfft;
    
    % MNF e MDF "reais"
    [MNF_real, MDF_real] = compute_mnf_mdf(S_real, f_real);
    
    %% 2. Método de Bartlett
    fprintf('Aplicando método de Bartlett...\n');
    [S_bartlett, f_bartlett] = compute_bartlett(x, fs, segment_ms, windowType);
    [MNF_bartlett, MDF_bartlett] = compute_mnf_mdf(S_bartlett, f_bartlett);
    
    %% 3. Método de Welch
    fprintf('Aplicando método de Welch...\n');
    [S_welch, f_welch] = compute_welch(x, fs, segment_ms, overlap_pct, windowType);
    [MNF_welch, MDF_welch] = compute_mnf_mdf(S_welch, f_welch);
    
    %% 4. Calcular erros percentuais
    erro_MNF_bartlett = abs(MNF_real - MNF_bartlett) / MNF_real * 100;
    erro_MDF_bartlett = abs(MDF_real - MDF_bartlett) / MDF_real * 100;
    erro_MNF_welch = abs(MNF_real - MNF_welch) / MNF_real * 100;
    erro_MDF_welch = abs(MDF_real - MDF_welch) / MDF_real * 100;
    
    %% 5. Armazenar resultados
    results.(sig_file) = struct(...
        'signal_name', sig_name, ...
        'MNF_real', MNF_real, ...
        'MDF_real', MDF_real, ...
        'MNF_bartlett', MNF_bartlett, ...
        'MDF_bartlett', MDF_bartlett, ...
        'MNF_welch', MNF_welch, ...
        'MDF_welch', MDF_welch, ...
        'erro_MNF_bartlett', erro_MNF_bartlett, ...
        'erro_MDF_bartlett', erro_MDF_bartlett, ...
        'erro_MNF_welch', erro_MNF_welch, ...
        'erro_MDF_welch', erro_MDF_welch, ...
        'S_real', S_real, ...
        'S_bartlett', S_bartlett, ...
        'S_welch', S_welch, ...
        'f_real', f_real, ...
        'f_bartlett', f_bartlett, ...
        'f_welch', f_welch ...
    );
    
    %% 6. Exibir resultados
    fprintf('\nResultados para %s:\n', sig_name);
    fprintf('  MNF Real:     %.2f Hz\n', MNF_real);
    fprintf('  MNF Bartlett: %.2f Hz (erro: %.2f%%)\n', MNF_bartlett, erro_MNF_bartlett);
    fprintf('  MNF Welch:    %.2f Hz (erro: %.2f%%)\n', MNF_welch, erro_MNF_welch);
    fprintf('\n');
    fprintf('  MDF Real:     %.2f Hz\n', MDF_real);
    fprintf('  MDF Bartlett: %.2f Hz (erro: %.2f%%)\n', MDF_bartlett, erro_MDF_bartlett);
    fprintf('  MDF Welch:    %.2f Hz (erro: %.2f%%)\n', MDF_welch, erro_MDF_welch);
    
    %% 7. Plotar espectros
    figure('Name', ['Espectros - ' sig_name], 'Position', [100, 100, 1200, 400]);
    
    subplot(1, 3, 1);
    plot(f_real, 10*log10(S_real + eps), 'b-', 'LineWidth', 1.5);
    grid on; xlabel('Frequência (Hz)'); ylabel('PSD (dB)');
    title(['Espectro Real - ' sig_name]);
    xlim([0, min(3000, fs/2)]);
    
    subplot(1, 3, 2);
    plot(f_bartlett, 10*log10(S_bartlett + eps), 'r-', 'LineWidth', 1.5);
    grid on; xlabel('Frequência (Hz)'); ylabel('PSD (dB)');
    title(['Método de Bartlett - ' sig_name]);
    xlim([0, min(3000, fs/2)]);
    
    subplot(1, 3, 3);
    plot(f_welch, 10*log10(S_welch + eps), 'g-', 'LineWidth', 1.5);
    grid on; xlabel('Frequência (Hz)'); ylabel('PSD (dB)');
    title(['Método de Welch - ' sig_name]);
    xlim([0, min(3000, fs/2)]);
    
    % Adicionar linhas verticais para MNF e MDF
    for subplot_idx = 1:3
        subplot(1, 3, subplot_idx);
        hold on;
        switch subplot_idx
            case 1
                xline(MNF_real, 'k--', 'MNF', 'LineWidth', 1);
                xline(MDF_real, 'k:', 'MDF', 'LineWidth', 1);
            case 2
                xline(MNF_bartlett, 'k--', 'MNF', 'LineWidth', 1);
                xline(MDF_bartlett, 'k:', 'MDF', 'LineWidth', 1);
            case 3
                xline(MNF_welch, 'k--', 'MNF', 'LineWidth', 1);
                xline(MDF_welch, 'k:', 'MDF', 'LineWidth', 1);
        end
        hold off;
    end
    
    % Plotar forma de onda do sinal
    figure('Name', ['Sinal - ' sig_name], 'Position', [100, 600, 800, 300]);
    t_signal = (0:length(x)-1) / fs;
    plot(t_signal, x, 'b-');
    grid on; xlabel('Tempo (s)'); ylabel('Amplitude');
    title(['Forma de Onda - ' sig_name]);
end

%% Resumo final
fprintf('\n=== RESUMO FINAL ===\n');
fprintf('Parâmetros utilizados:\n');
fprintf('  - Janela: %s, %d ms\n', windowType, segment_ms);
fprintf('  - Overlap (Welch): %d%%\n', overlap_pct);
fprintf('  - Frequência de amostragem: %d Hz\n', fs);
fprintf('\n');

% Tabela resumo
fprintf('%-15s | %-8s | %-8s | %-8s | %-8s | %-8s | %-8s\n', ...
    'Sinal', 'MNF Real', 'MNF Bart', 'Erro%%', 'MNF Welch', 'Erro%%', '');
fprintf('%s\n', repmat('-', 1, 80));

for sig_idx = 1:length(signal_files)
    sig_file = signal_files{sig_idx};
    r = results.(sig_file);
    fprintf('%-15s | %8.1f | %8.1f | %7.1f | %9.1f | %6.1f |\n', ...
        r.signal_name, r.MNF_real, r.MNF_bartlett, r.erro_MNF_bartlett, ...
        r.MNF_welch, r.erro_MNF_welch);
end

fprintf('\n');
fprintf('%-15s | %-8s | %-8s | %-8s | %-8s | %-8s | %-8s\n', ...
    'Sinal', 'MDF Real', 'MDF Bart', 'Erro%%', 'MDF Welch', 'Erro%%', '');
fprintf('%s\n', repmat('-', 1, 80));

for sig_idx = 1:length(signal_files)
    sig_file = signal_files{sig_idx};
    r = results.(sig_file);
    fprintf('%-15s | %8.1f | %8.1f | %7.1f | %9.1f | %6.1f |\n', ...
        r.signal_name, r.MDF_real, r.MDF_bartlett, r.erro_MDF_bartlett, ...
        r.MDF_welch, r.erro_MDF_welch);
end

fprintf('\nAnálise concluída! Verifique as figuras geradas.\n');

% Salvar workspace para análise posterior
save('resultados_atividade02.mat', 'results', 'fs', 'segment_ms', 'overlap_pct', 'windowType');