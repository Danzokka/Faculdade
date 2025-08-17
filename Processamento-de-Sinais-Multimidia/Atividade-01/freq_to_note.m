function [noteNames, semitoneOffset] = freq_to_note(fHz, concertA)
% FREQ_TO_NOTE  Map frequencies to nearest musical note (12-TET).
%
%   [noteNames, semitoneOffset] = freq_to_note(fHz, concertA)
%
% INPUTS
%   fHz        : vector of frequencies in Hz.
%   concertA   : reference A4 frequency (default 440 Hz).
%
% OUTPUTS
%   noteNames       : cellstr with note name + octave (e.g., 'A4', 'C#5').
%   semitoneOffset  : signed fractional semitone distance (f - nearestNote) in semitones.
%
% NOTES
%   - Frequencies <= 0 map to empty string.
%   - Uses equal temperament relative to A4.
%
if nargin < 2 || isempty(concertA)
    concertA = 440;
end

names = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
fHz = fHz(:);
noteNames = cell(size(fHz));
semitoneOffset = nan(size(fHz));
for i = 1:numel(fHz)
    f = fHz(i);
    if f <= 0 || ~isfinite(f)
        noteNames{i} = '';
        continue;
    end
    n = 12*log2(f/concertA); % semitones from A4
    nRound = round(n);
    semitoneOffset(i) = n - nRound; % fraction difference
    % MIDI number (A4=69). nRound = midi - 69
    midi = nRound + 69;
    octave = floor(midi/12) - 1; % MIDI octave conv (C4=60 => (60/12)-1=4)
    idx = mod(midi,12) + 1; % 1..12
    noteNames{i} = sprintf('%s%d', names{idx}, octave);
end
end
