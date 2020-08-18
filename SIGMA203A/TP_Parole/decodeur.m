% Brique TSECS
% Programme pour le TP "Mod�lisation AR et pr�diction"
% Une version (simplifi�e) du codeur LPC10

clear

% D�finition des param�tres 
Fe = 8000;
N = 240;
P = 16;

fid_canal = fopen('canal');
signal_y_hat = [];
signal_x_hat = [];
etat_filtre_synthese = zeros(P, 1);
indice = N;
while 1
    % Lecture des infos transmisses dans le "canal"
    a = fread(fid_canal, P, 'float32');
    if length(a) == 0
        break
    end
    sigma2 = fread(fid_canal, 1, 'float32');
    voise = fread(fid_canal, 1, 'short');
    pitch = fread(fid_canal, 1, 'short');

    % D�termination de l'entr�e du filtre de synth�se
    y_hat = zeros(N,1);
    if voise
        % Train d'impulsions
        indice = indice - N - 1;
        if indice < 1
            indice = 1 - pitch;
        end
        amplitude = sqrt(pitch*sigma2);
        while indice+pitch <= N
            indice = indice + pitch;
            y_hat(indice) = amplitude;
        end
    else
        % Bruit blanc
        y_hat = sqrt(sigma2)*randn(N,1);
    end
    
    % Calcul du signal synth�tique
    x_hat = zeros(N,1);
    for n = 1:N
        x_hat(n) = y_hat(n) - a'*etat_filtre_synthese; 
        etat_filtre_synthese(2:P) = etat_filtre_synthese(1:P-1);
        etat_filtre_synthese(1) = x_hat(n);
    end
    
    % Sauvegarde
    signal_y_hat = [signal_y_hat; y_hat];
    signal_x_hat = [signal_x_hat; x_hat];
end
fclose(fid_canal);

wavwrite(signal_x_hat, Fe, 'voix_reconstruite');

vmax_signal_x_hat = max(abs(signal_x_hat));
figure(4); hold off
plot(signal_x_hat); hold on
plot(signal_y_hat, 'r')
axis([1 length(signal_x_hat) 1.1*vmax_signal_x_hat*[-1 1]])