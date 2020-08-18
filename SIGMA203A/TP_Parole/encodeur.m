% Brique TSECS
% Programme pour le TP "Mod�lisation AR et pr�diction"
% Une version (simplifi�e) du codeur LPC10

clear
init_visualisations

% D�finition des param�tres 
Fe = 8000;
N = 240;
P = 16;

% Lecture du signal
% signal_x = wavread('voix_femme.wav', [1300 5500]);
signal_x = wavread('voix_femme.wav', [1000 20000]);
% signal_x = wavread('voix_enfant.wav', [100 20000]);
% signal_x = wavread('voix_homme.wav', [100 20000]);
Nbre_ech = length(signal_x);
Nbre_fen = fix(Nbre_ech/N);
vmax_signal_x = max(abs(signal_x));
figure(1); hold off
plot(signal_x); hold on
axis([1 Nbre_ech 1.1*vmax_signal_x*[-1 1]])

%%%%%%%%%%%%%%%%
% A l'encodeur %
%%%%%%%%%%%%%%%%

fid_canal = fopen('canal', 'w');
etat_filtre_analyse = zeros(P, 1);
pitch_min = 20;
pitch_max = pitch_min + 127;
x_fen_precedente = zeros(N, 1);
for no_fen = 1:Nbre_fen
    % D�finition de la fenetre d'analyse courante
    n1 = (no_fen-1)*N + 1;
    n2 = no_fen*N;
    x = signal_x(n1:n2);
    
    % Calcul des coefficients du filtre d'analyse (et de synth�se)
    [a, sigma2] = analyse_lpc(x, P);
   
    % D�termination de la p�riode fondamentale dans le cas vois�
    voise = 1;
    if voise
        vecteur = [x_fen_precedente; x];
        pitch = calcul_du_pitch(vecteur, pitch_min, pitch_max);
        x_fen_precedente = x;
    else
        pitch = pitch_min;
    end
    
    % Transfert dans le "canal"
    fwrite(fid_canal, a, 'float32');
    fwrite(fid_canal, sigma2, 'float32');
    fwrite(fid_canal, voise, 'short');
    fwrite(fid_canal, pitch, 'short');
    
    % Calcul et visualisation du signal r�siduel
    signal = [x(N:-1:1); etat_filtre_analyse];
    y = zeros(N,1);
    for n = 1:N
        y(n) = [1; a]'*signal(N-n+1:N+P-n+1);
    end
    etat_filtre_analyse = signal(1:P);
    figure(1);
    plot(n1:n2, y, 'r')
    plot(n2*[1 1], 1.1*vmax_signal_x*[-1 1], 'g')

    % Calcul du p�riodogramme et du spectre LPC de x(n) et visualisations
    temp = fft(x);
    perio_x = (abs(temp(1:N/2+1,1)).^2)/N;
    perio_x_db = 10*log10(perio_x);
    den = abs(fft([1; a],N));
    spec_lpc_x_db = 10*log10(sigma2) - 20*log10(den(1:N/2+1));
    axe_freq = (0:N/2)*Fe/1000/N;
    figure(2); hold off
    plot(axe_freq, perio_x_db); hold on
    plot(axe_freq, spec_lpc_x_db, 'r')
    axis([0 4 -50 0])
    drawnow
    %fprintf('pause \n'); pause
end
fclose(fid_canal);
