%Script pour la detection multi-pitch
% reference: Klapuri
% mais avec detection de pitch par produit spectral
% idem tpmultipitch mais avec annulation des bandes spectrales 
%entre -1/N et 1/N autour de la freq. centrale
% au lieu d'une soustraction ponderee par TF de fenetre de Hamming
% Author: G. Richard, Janv. 2005 - MAJ:2010
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc


%Lecture du signal
[x,Fs,nbits]=wavread('A4_piano.wav');
soundsc(x,Fs);

spect_smooth=2; % options: 0: no spectral smoothness
                %          1: spectral smoothness principle with triangle 
                %           2 spectral smoothness principle with mean of three harmonics 

N=floor(0.7*Fs);      % Window size of signal analyses (only one window is analysed)
dF=Fs/N;              %precision frequentielle minimale desiree
Fmin=100;             
Fmax=900;
H=4;                  % H = nombre de versions compressees
prod_spec = 1;        % methode pour la detection de pitch est produit spectral sinon par autocorrelation
freq_fond=[];         % tableau contenant la valeur des frequences fondamentales
seuil_F0 = 0.005;     % seuil pour l'acceptation d'un nouveau pitch

% beta coef d'inharmonicite
beta=1.0;

% fenetrage
w=hamming(N);

offset=floor(0.1*Fs);
xw=x(offset+1:offset+N).*w;    %xw est la fenetre de signal analyse

Nfft=Fs/dF;

%calcul ordre en fonction de la precision dF
p = nextpow2(Nfft);
Nfft=2^p;

%calcul FFT
Xk=fft(xw,Nfft);

%specgram(xw);

%normalisation
Xk=Xk/max(abs(Xk)+eps);

f=(0:Nfft-1)/Nfft+eps;

% frequence maximale
Rmax = floor((Nfft-1)/(2*H));

%boucle sur le nombre de pitch
Energ_ratio=1;
Energ_Xk_ini=abs(Xk)'*abs(Xk);
Xk_ini=Xk;
pitch=0;
figure(1);
        plot((1:Nfft/2)*(Fs/Nfft), 20*log10(abs(Xk(1:Nfft/2))),'b');
%         hold on
%         plot([1:Nfft/2]*(Fs/Nfft),20*log10(abs(spec_harmo2(1:Nfft/2))),'b');
%         hold off;
        axis([0 5000 -80 0]);
        xlabel('Frequences (Hz)','fontsize',14);
        ylabel('Spectre d''Amplitude (dB)','fontsize',14);      
        title('Spectre d''amplitude du signal original','fontsize',14);
        pause
        %fig2jpg
        
while Energ_ratio > seuil_F0
    
    %detection de F0
    %Calcul produit spectral

    
    
    %Soustraction du F0 dominant
    %localisation des harmoniques avec un coefficient d'inharmonicite tolere
    % beta: coef d'inharmonicte
    % n: numero de l'harmonique
    % spec_harmo est le spectre d'harmoniques

    
    
    %suppression des sinusoides
    % TF d'une fenetre de Hamming
    %     
    %     figure(2)
    %     plot(20*log10(abs(Whsym)));
    %     spec_harmo2=spec_harmo;
    %    spec_harmo3=spec_harmo;
    
    
    
    
    %annulation de toutes les frequences (methode normale)
            
    
 %   pause
end
%fin de boucle
disp(freq_fond);