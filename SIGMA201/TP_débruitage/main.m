close all;
clear all;
clc

% charger l'image
x = double(imread('lena.pgm'));
% bruiter l'mage
variance = 30;
bruit = variance*randn(512);
s = x+bruit;
% afficher l'image originale et bruitée
figure;
image(uint8(x));
axis image;
colormap(gray(256));
axis off;
figure;
image(uint8(s)); 
axis image;
colormap(gray(256)); 
axis off;

%% Effectuer la transformée ondelette
qmf = MakeONFilter('Daubechies',8);
L = 5;
X_TO = FWT2_PO(x,L,qmf);
S_TO = FWT2_PO(s,L,qmf);

%% afficher l'image decomposée
figure
imagesc(log10(abs(X_TO)+1));
figure
coeff = wt_view(X_TO,4);
figure
imagesc(log10(abs(S_TO)+1));
figure
coeff_bruite = wt_view(S_TO,4);

%% Bruit de tansformée 
BT = S_TO-X_TO;
figure
hist(BT(:),512);
figure
hist(bruit(:),512);
moyenneBT = mean(BT(:));
varBT = std(BT(:));

%% Calcul de SNR de chaque sous-bande
SNR = SNRSB(L,coeff,BT)';
tmp = s.^2;
SNRspatial = 10*log10(mean(tmp(:)/var(s(:))));

%% Débruitage
% Soft Thresholding
S_DBRT_ST = Seuillage_doux(S_TO,4,qmf,variance);
figure 
image(uint8(S_DBRT_ST)); 
axis image; 
colormap(gray(256)); 
axis off;
EQM_ST = mean((x(:)-S_DBRT_ST(:)).^2);

% Hard Thresholding
S_DBRT_HT = Seuillage_dur(S_TO,4,qmf,variance);
figure
image(uint8(S_DBRT_HT)); 
axis image;
colormap(gray(256)); 
axis off;
EQM_HT = mean((x(:)-S_DBRT_HT(:)).^2);

%% SURE Thresholding
S_DBRT_SURE = SURE(S_TO,4,qmf,variance);
figure
image(uint8(S_DBRT_SURE)); 
axis image;
colormap(gray(256)); 
axis off;
EQM_SURE = mean((x(:)-S_DBRT_SURE(:)).^2);

%% Filtrage de Wiener
S_DBRT_FW = wiener2d(s,variance);
figure
image(uint8(S_DBRT_FW));
axis image;
colormap(gray(256));
axis off;
EQM_FW = mean((x(:)-S_DBRT_FW(:)).^2);

%% Méthode estimation de l'écart type
detail = getsb(S_TO,3*4+1,4);
variance_est = (1/0.6745)*median(abs(detail(:)));

S_DBRT_ST2 = Seuillage_doux(S_TO,4,qmf,variance_est);
S_DBRT_HT2 = Seuillage_doux(S_TO,4,qmf,variance_est);
S_DBRT_SURE2 = SURE(S_TO,4,qmf,variance_est);
S_DBRT_FW2 = wiener2d(s,variance_est);

figure 
image(uint8(S_DBRT_ST2)); 
axis image; 
colormap(gray(256)); 
axis off;
EQM_ST2 = mean((x(:)-S_DBRT_ST2(:)).^2);

figure 
image(uint8(S_DBRT_HT2)); 
axis image; 
colormap(gray(256)); 
axis off;
EQM_HT2 = mean((x(:)-S_DBRT_HT2(:)).^2);

figure 
image(uint8(S_DBRT_SURE2)); 
axis image; 
colormap(gray(256)); 
axis off;
EQM_SURE2 = mean((x(:)-S_DBRT_SURE2(:)).^2);

figure 
image(uint8(S_DBRT_FW2)); 
axis image; 
colormap(gray(256)); 
axis off;
EQM_FW2 = mean((x(:)-S_DBRT_FW2(:)).^2);