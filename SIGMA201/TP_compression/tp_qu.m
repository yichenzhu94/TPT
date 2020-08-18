%% TP compression d'image
close all; 
clear all; 
clc

%% Charger une image et l'afficher
x= double(imread('lena.pgm'));
bpp = 8; % bits per pixel
dyn = 2^bpp; % pixel depth 
figure; 
image(uint8(x)); 
axis image; 
colormap(gray(256)); 
axis off; 
title('Image originale'); 
set(gcf, 'Position', [100   387   682   603]);

%% Histogramme de l'image
figure; 
hist(x(:), 0:dyn) % x(:) permet de convertir x en vecteur puis 0:dyn permet
% de pour chaque profondeur compter le nombre de pixel, sinon la valeur par
% défault est 10, l'axe x de l'histogramme est quantifié
title('Histogramme de l''image originale');


%% Quantification uniforme

% Afficher la relation entrée sortie du QU
bitrate = 4; % nombre de bits nécessaire pour représentation les états de
% quantification
delta = 2^(bpp+1-bitrate); %+1 needed to take into account negative values
in=-dyn+1:dyn-1;
figure;
plot(in,qu(in, delta),'o'); 
hold on
line([-dyn dyn], [0 0]); 
line([0 0], [-dyn dyn]);
title(sprintf('Relation entrée/sortie du QU à %d bit', bitrate));
axis([min(in) max(in)  min(in) max(in)]);
xlabel('x'); 
ylabel('Q(x)')

%%  QU de l'image
bitrate = 5;
delta = 2^(bpp+1-bitrate);
XQ =qu(x,delta);
figure; 
image(uint8(XQ)); 
axis image; 
colormap(gray(256));
axis off;
MSE = (sum((x(:)-XQ(:)).^2))/(512*512);
PSNR = 10*log10(dyn.^2/MSE);
title (sprintf('Image quantifiée sur %d bits - PSNR: %5.2f',...
    bitrate, PSNR));
set(gcf, 'Position', [800  387   682   603]);
figure;
hist(XQ(:), 0:dyn);
title(sprintf('Histogramme image quantifié sur %d bits', bitrate));

%% Courbe RD du QU
DELTA= 128:-2:1;
R =  zeros(size(DELTA));
D = zeros(size(DELTA));
PSNR = zeros(size(DELTA));
for iDelta = 1:numel(DELTA),
    delta = DELTA(iDelta);
    R(iDelta) = bpp-log2(delta);
    XQ = qu(x,delta) ;
    D(iDelta)= power(255,2)/(3*power(2,2*R(iDelta))) ;
    PSNR(iDelta) = 10*log10(dyn^2/ mean((x(:)-XQ(:)).^2)) ;
end

figure; 
plot(R,D, 'x'); 
title('Courbe D(R) quantificateur uniforme');
xlabel('Rate [bpp]'); 
ylabel('D - MSE');

figure; 
plot(R,PSNR, 'o'); 
title('Courbe Q(R) quantificateur uniforme');
xlabel('Rate [bpp]'); 
ylabel('PSNR [dB]');

figure; 
plot(R(2:end), diff(PSNR)./diff(R), 'x');
title('Points  dQ/dR quantificateur uniforme');
xlabel('Rate [bpp]');
ylabel(' d PSNR/d R [dB]');

%% Sauvegarde des résultats RD pour comparaison
save QU R D PSNR

%% Courbe RD sur données aléatoires

U = 255.*rand(100,1);
figure; 
hist(U(:),dyn); % Vérifie la distribution de U 
title('Histogramme d''une v.a. uniforme U(0,255)');

DELTA= 128:-2:1;
R=  zeros(size(DELTA));
D = zeros(size(DELTA));
PSNR = zeros(size(DELTA));
for iDelta = 1:numel(DELTA),
    delta = DELTA(iDelta);
    R(iDelta) = bpp-log2(delta);
    UQ = qu(U,delta);
    D(iDelta)=  mean( (U(:)-UQ(:)).^2  );
    PSNR(iDelta) = 10*log10(dyn^2/ mean( (U(:)-UQ(:)).^2  ));
end

figure;
plot(R,D, 'x'); 
title('Courbe D(R) quantificateur uniforme');
xlabel('Rate [bpp]'); 
ylabel('D - MSE');

figure; 
plot(R,PSNR, 'o');
title('Courbe Q(R) quantificateur uniforme');
xlabel('Rate [bpp]');
ylabel('PSNR [dB]');

figure;
plot(R(2:end),diff(PSNR)./diff(R), 'x');
title('Points  dQ/dR quantificateur uniforme');
xlabel('Rate [bpp]');
ylabel('PSNR [dB]');