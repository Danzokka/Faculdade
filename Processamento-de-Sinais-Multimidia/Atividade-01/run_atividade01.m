%% Atividade 01 - Processamento de Sinais Multimídia
% Espectrograma via STFT + identificação de frequência dominante / nota
% Autor: (adicione seu nome / grupo)
% Data: %s
% -------------------------------------------------------------------------
% Este script demonstra o uso de compute_stft para:
%   1) Trecho inicial de música simples (um instrumento)
%   2) Trecho de voz
% Caso não encontre arquivos de áudio reais, ele gera sinais sintéticos para teste.
% Ajuste os caminhos abaixo conforme necessário.

fprintf('Iniciando Atividade 01 (%s)\n', datestr(now));

%% CONFIGURAÇÕES GERAIS
audioMusica = 'musica.wav';    % coloque um arquivo curto (<=5s) de um instrumento
audioVoz    = 'voz.wav';       % coloque um arquivo de voz (~frase curta)

segment_ms  = 40;      % duração da janela (ms)
overlap_pct = 50;      % overlap (%)
windowType  = 'hann';  % 'hann' | 'hamming' | 'rect'

%% 1) MÚSICA (OU SINAL SINTÉTICO)
if exist(audioMusica,'file')
    [xMus, fsMus] = audioread(audioMusica);
    if size(xMus,2) > 1
        xMus = mean(xMus,2); % mono
    end
    fprintf('Arquivo de música encontrado: %s (fs=%d)\n', audioMusica, fsMus);
else
    % Gera melodia sintética de 4 notas (A4, C5, E5, D5)
    fsMus = 16000;
    durNota = 0.6; t = 0:1/fsMus:durNota-1/fsMus;
    fNotas = [440 523.25 659.25 587.33];
    xMus = [];
    for f0 = fNotas
        xMus = [xMus; 0.8*sin(2*pi*f0*t)']; %#ok<AGROW>
    end
    fprintf('Gerado sinal sintético de música (fs=%d)\n', fsMus);
end

[Xmus, fMus, tMus, peakMus, idxMus] = compute_stft(xMus, fsMus, segment_ms, overlap_pct, windowType);
[noteMus, offMus] = freq_to_note(peakMus);

%% 2) VOZ (OU SINAL SINTÉTICO)
if exist(audioVoz,'file')
    [xVoz, fsVoz] = audioread(audioVoz);
    if size(xVoz,2) > 1
        xVoz = mean(xVoz,2);
    end
    fprintf('Arquivo de voz encontrado: %s (fs=%d)\n', audioVoz, fsVoz);
else
    % Sinal de voz sintético aproximado (fundamental ~150 Hz com formantes simples)
    fsVoz = 16000;
    dur = 3; n = (0:1/fsVoz:dur-1/fsVoz)';
    f0 = 150 + 10*sin(2*pi*0.5*n); % leve vibrato
    phase = cumsum(2*pi*f0/fsVoz);
    vozBase = sin(phase);
    % Formantes simples (combinação de harmônicos)
    voz = vozBase + 0.4*sin(2*phase) + 0.2*sin(3*phase);
    xVoz = voz .* (0.5+0.5*hann(length(voz),'periodic')); % janela global fade
    fprintf('Gerado sinal sintético de voz (fs=%d)\n', fsVoz);
end

[XVoz, fVoz, tVoz, peakVoz, idxVoz] = compute_stft(xVoz, fsVoz, segment_ms, overlap_pct, windowType);

%% PLOT: ESPECTROGRAMA MÚSICA
figure('Name','Spectrogram - Música');
imagesc(tMus, fMus, 20*log10(abs(Xmus)+1e-12)); axis xy; colormap turbo; colorbar;
ylabel('Frequência (Hz)'); xlabel('Tempo (s)'); title('Espectrograma Música (dB)');
hold on; plot(tMus, peakMus,'w','LineWidth',1); hold off;

%% PLOT: ESPECTROGRAMA VOZ
figure('Name','Spectrogram - Voz');
imagesc(tVoz, fVoz, 20*log10(abs(XVoz)+1e-12)); axis xy; colormap turbo; colorbar;
ylabel('Frequência (Hz)'); xlabel('Tempo (s)'); title('Espectrograma Voz (dB)');
hold on; plot(tVoz, peakVoz,'w','LineWidth',1); hold off;

%% TABELA DAS FREQUÊNCIAS (MÚSICA)
fprintf('\nFrequências dominantes (música) por janela:\n');
fprintf('Janela\tTempo(s)\tPico(Hz)\tNota\tOffset(semitons)\n');
for m = 1:numel(peakMus)
    fprintf('%3d\t%7.3f\t%8.2f\t%-4s\t%+.2f\n', m, tMus(m), peakMus(m), noteMus{m}, offMus(m));
end

%% RESULTADOS RESUMIDOS
fprintf('\nResumo Música: %d janelas, janela %d ms, overlap %.1f%%.\n', numel(peakMus), segment_ms, overlap_pct);
fprintf('Faixa de frequências analisada: 0 a %.1f Hz.\n', fMus(end));
fprintf('Frequências únicas aproximadas (nota) encontradas: %s\n', strjoin(unique(noteMus(~cellfun(@isempty,noteMus))),' '));

fprintf('\nAtividade 01 concluída.\n');
