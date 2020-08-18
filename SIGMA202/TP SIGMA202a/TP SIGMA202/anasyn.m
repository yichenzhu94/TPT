% anasyn.m
% cadre de programmation d'un système d'analyse/synthèse
% trame par trame;
clear all; close all;

% recupération du signal
[name,chem] = uigetfile('*.wav','choisir un fichier wav');
[s,Fe] = wavread([chem,name]);s = s(:,1);

% preemphasis
s = filter([1 -.98],1,s);

% paramètres de l'analyse
Ltrame = .04 ; % longueur des trames en s
p = 12; % ordre de modélisation AR
Rec = 50; % recouvrement des trames en %
Fmax = 200; % frequence max de voisement
Fmin = 60;  % frequence min de voisement

N = length(s);
Nx = round(Ltrame*Fe) ; % longueur des trames en echantillons
hop = round(Nx*Rec/100);% décalage entre trames
Ntr = fix( (N-Nx)/hop ); % nbre de trame à traiter
minT = fix(Fe/Fmax); 
maxT = ceil(Fe/Fmin);

ss = zeros(N,1); % on reserve l'espace mem. pour la synthese
pitch = zeros(1,Ntr); % freq. estimées.
coeff = zeros(p,Ntr); % coeff. AR estimés.
sig = zeros(1,Ntr);   % puissances estimées

for k=1:Ntr
    deb = (k-1)*hop+1;fin = deb+Nx-1;
    x = s(deb:fin) ; % la trame courante est dans x
    
    % ici votre code:
    % detection du pitch
    % estimation AR
    
    pitch(k) = ; % detection du pitch
    sig(k) = ; % estimation de gamma(0)
    phi(:,k) = ; % estimation des phi_k
    
%     % verif graphique
%     xf = fft(x,1024);xf = 10*log10(abs(xf(1:512)).^2/Nx);
%     xar = 1./abs(fft([1;-phi(:,k)],1024));xar = 20*log10(sqrt(sig(k))*xar(1:512));
%     plot(xf);hold on;plot(xar,'r');pause;close
    
    % resynthèse
    if pitch(k) ~= 0
        T = pitch(k);
        pT = zeros(Nx+p,1);pT(lag:T:end)=1;
        I = find(pT(hop+1:end));
        lag = min(I);
        xs = filter(1,[1 ;-phi(:,k)],pT);
        xs =xs(p+1:end); xs = xs*sqrt(sig(k)/var(xs));
    else
        xs = randn(Nx+p,1);
        xs = filter(1,[1 ;-phi(:,k)],xs);
        xs = xs(p+1:end);xs = xs*sqrt(sig(k)/var(xs));
    end
    ss(deb:fin) = ss(deb:fin)+xs.*myhann(Nx);
end
ss = filter(1,[1 -.98],ss);


subplot(311);
t = (0:N-1)/Fe;plot(t,s);
subplot(312);
tp = (0:Ntr-1)*hop/Fe;plot(tp,pitch);
subplot(313);
plot(tp,sig);
   
    
