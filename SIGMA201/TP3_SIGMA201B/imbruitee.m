%% TP3- SIGMA 201B- D�BRUITAGE

%% 
close all;   clear

%% Charger une image 

x= double(imread('lena.pgm'));
sz=size(x);
bruit= 30*randn(sz);
xb=x+bruit;

%Affichage

figure(); 
subplot(1,2,1)
image(uint8(x)); axis image; colormap(gray(256)); axis off;
title('Image original')
subplot(1,2,2);
image(uint8(xb)); axis image; colormap(gray(256)); axis off; 
title('Image bruit�e')


%%  Cr�ation du filtre et calcul de la transform�e en Ondelettes 

qmf = MakeONFilter('Daubechies', 8);

% Calcul de la transform�e en ondelette discrete (p�riodisation)
nDecLev = 4; % Nombre de niveaux de d�composition 
imSizeLog = log2(size(x,1)); 
X_TO = FWT2_PO(x,imSizeLog-nDecLev,qmf); % L=imSizeLog-nDecLev; dans ce cas, L vaut 5. 
X_TB = FWT2_PO(xb,imSizeLog-nDecLev,qmf);

% Affichage transform�e en ondelettes image original
figure()
wt_view(X_TO, nDecLev);
title(sprintf('Decomposition sur %d niveaux, remise � l��chelle des sous-bandes: original',nDecLev));

% Affichage transform�e en ondelettes image bruit�e
figure(); wt_view(X_TB, nDecLev);
title(sprintf('Decomposition sur %d niveaux, remise � l��chelle des sous-bandes: bruit�e',nDecLev));

% Affichage avec �chelle globale 
figure() ; imagesc(log10(abs(X_TO)+1)); axis image; axis off; colorbar;
title(sprintf('Decomposition sur %d niveaux, �chelle log unique image original',nDecLev));

% Affichage avec �chelle globale 
figure(); imagesc(log10(abs(X_TB)+1)); axis image; axis off; colorbar;
title(sprintf('Decomposition sur %d niveaux, �chelle log unique image bruit�e',nDecLev));


%% Histogrammes des bruits

figure()
histogram(bruit(:)) %Histogramme du bruit ajout�
title('Histogramme du bruit spatiale');
bruitTO=X_TB-X_TO;
moyenBT=mean(bruitTO(:));
ecartBT=std(bruitTO(:));
figure()
histogram(bruitTO(:))
title('Histogramme du bruit affectant les coefficients d�ondelettes');

%% Commentaire
% On observe que les deux histogrammes correspondent � la m�me
% distribution. C'est � dire, apr�s transformation, le bruit reste gaussien
% de moyenne nulle et �cart-type de 30 environ (on l'a v�rifi� en calculant 
% la moyenne et l'�cart type empiriques de l'image transform�e). Cela peut s'expliquer �
% partir du fait que la transformation en ondelettes est une transformation
% orthogonale, et donc pr�serve les propiet�s du signal original. 

%% SNR dans les sousbandes et dans l'image original

for i=1:3*nDecLev+1
    
    sousbO = getsb(X_TO, i, nDecLev);
    sousbB= getsb(X_TB, i, nDecLev);
    bruit=sousbB-sousbO;
    varb=var(bruit(:));
    coeffim2=sousbB.^2;
    SNR(i)=10*log10(mean(coeffim2(:))/varb);
    
end

disp('Le SNR qu�on obtient pour chaque sous bande c�est:')

SNR

coeffim2=xb.^2;
varb=var(xb(:));
SNRspatial=10*log10(mean(coeffim2(:))/varb);

disp('Le SNR qu�on obtient pour l''image c''est:')
SNRspatial


%% Commentaire
% On constate que le SNR (exprim� en dB) diminue en augmentant la sousbande
% d'approximation et tend vers zero. Cela implique que le rapport signal
% sur bruit tends vers 1: en augmentant les sousbandes d'approximation, il
% y a un grand nombre de coefficients qui deviennent zero, et il ne reste que du bruit dans la sousbande. C'est pour ce que 
% la puissance de l'image contenue dans la sousbande et du bruit deviennent �gales. 
% 
% Par rapport au SNR de l'image, on constate que celui dans les premi�res
% sousbandes d'approximation est plus �l�v�. 
%% D�bruitage- Seuillage SOFT

jmax=nDecLev;
K= imSizeLog;
Km= K*(1-4^(-jmax));

seuilU=30*sqrt(2*log(Km));

imThreshT=SoftThresh(X_TB, seuilU);

approximation=getsb(X_TB, 1, nDecLev);

for i=1:size(approximation,1);
    for j=1:size(approximation,2);
        imThreshT(i,j)=approximation(i,j);
    end
end


imdebruiteeS=IWT2_PO(imThreshT,imSizeLog-nDecLev,qmf);

% figure(); wt_view(imThreshT, nDecLev);
figure(); image(uint8(imdebruiteeS)); axis image; colormap(gray(256)); axis off; 
title('Seuillage doux');

EQMS=mean((x(:)-imdebruiteeS(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient c''est')
EQMS

%% D�bruitage- Seuillage HARD

imThreshT=HardThresh(X_TB, seuilU);

approximation=getsb(X_TB, 1, nDecLev);

for i=1:size(approximation,1);
    for j=1:size(approximation,2);
        imThreshT(i,j)=approximation(i,j);
    end
end

imdebruiteeH=IWT2_PO(imThreshT,imSizeLog-nDecLev,qmf);

% figure(); wt_view(imThreshT, nDecLev); 
figure(); image(uint8(imdebruiteeH)); axis image; colormap(gray(256)); axis off; 
title('Seuillage dur');

EQMH=mean((x(:)-imdebruiteeH(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient c''est %d')
EQMH


%% Seuillage SURE

y=(1/30)*X_TB;        

imThreshT1=HybridThresh(y(:)');
imThreshT=reshape(imThreshT1, size(x));

approximation=getsb(y, 1, nDecLev);

for i=1:size(approximation,1);
    for j=1:size(approximation,2);
        imThreshT(i,j)=approximation(i,j);
    end
end

imdebruiteeSU=IWT2_PO(30*imThreshT,imSizeLog-nDecLev,qmf);

% figure(); wt_view(imThreshT, nDecLev); 
figure(); image(uint8(imdebruiteeSU)); axis image; colormap(gray(256)); axis off; 
title('Seuillage SURE');

EQMSU=mean((x(:)-imdebruiteeSU(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient c''est')
EQMSU

%% Filtrage de Wiener

imdebruiteeW= wiener2d(xb, 30);

EQMSW=mean((x(:)-imdebruiteeW(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient c''est')
EQMSW

%% Comparison entre les seuillages

figure()
subplot(2,2,1)
image(uint8(imdebruiteeS)); axis image; colormap(gray(256)); axis off; 
title('Seuillage SOFT');
subplot(2,2,2);
image(uint8(imdebruiteeH)); axis image; colormap(gray(256)); axis off; 
title('Seuillage HARD');
subplot(2,2,3)
image(uint8(imdebruiteeSU)); axis image; colormap(gray(256)); axis off; 
title('Seuillage SURE');
subplot(2,2,4)
image(uint8(imdebruiteeW)); axis image; colormap(gray(256)); axis off; 
title('Filtrage Wiener');

%% Commentaire

% Par rapport aux autres m�thodes de d�bruitage, c'est le seuillage dur
% celui qui a l'erreur quadratique moyen le plus haut, et celui qui
% pr�serve plus le bruit en terms visuels. La m�thode qui a la meilleure
% performance c'est cela qui utilise le seuillage SURE pour faire le
% d�bruitage, car on obtient en l'appliqant l'erreur quadratique moyen le
% plus bas. 

% La seule m�thode qui a une performance plus faible que cela du filtrage
% de Weiner c'est le seuillage dur (en terms visuels et d'erreur
% quadratique moyen aussi). 

%% Performance des m�thodes en utilisant un �cart-type estim�

plusfinesb=getsb(X_TB, 3*nDecLev+1, nDecLev);

sigma=(1/0.6745)*median(abs(plusfinesb(:)));
% sigma=std(x(:));

seuilU=sigma*sqrt(2*log(Km));

imThreshT=SoftThresh(X_TB, seuilU);

approximation=getsb(X_TB, 1, nDecLev);

for i=1:size(approximation,1);
    for j=1:size(approximation,2);
        imThreshT(i,j)=approximation(i,j);
    end
end


imdebruiteeS=IWT2_PO(imThreshT,imSizeLog-nDecLev,qmf);

% figure(); wt_view(imThreshT, nDecLev);
figure(); image(uint8(imdebruiteeS)); axis image; colormap(gray(256)); axis off; 
title('Seuillage doux');

EQMS=mean((x(:)-imdebruiteeS(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient avec le seuillage doux c''est')
EQMS

% D�bruitage- Seuillage HARD

imThreshT=HardThresh(X_TB, seuilU);

approximation=getsb(X_TB, 1, nDecLev);

for i=1:size(approximation,1);
    for j=1:size(approximation,2);
        imThreshT(i,j)=approximation(i,j);
    end
end

imdebruiteeH=IWT2_PO(imThreshT,imSizeLog-nDecLev,qmf);

% figure(); wt_view(imThreshT, nDecLev); 
figure(); image(uint8(imdebruiteeH)); axis image; colormap(gray(256)); axis off; 
title('Seuillage dur');

EQMH=mean((x(:)-imdebruiteeH(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient avec le seuillage dur c''est %d')
EQMH


% Seuillage SURE

y=(1/sigma)*X_TB;        

imThreshT1=HybridThresh(y(:)');
imThreshT=reshape(imThreshT1, size(x));

approximation=getsb(y, 1, nDecLev);

for i=1:size(approximation,1);
    for j=1:size(approximation,2);
        imThreshT(i,j)=approximation(i,j);
    end
end

imdebruiteeSU=IWT2_PO(sigma*imThreshT,imSizeLog-nDecLev,qmf);

% figure(); wt_view(imThreshT, nDecLev); 
figure(); image(uint8(imdebruiteeSU)); axis image; colormap(gray(256)); axis off; 
title('Seuillage SURE');

EQMSU=mean((x(:)-imdebruiteeSU(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient avec le seuillage SURE c''est')
EQMSU

%Wiener

imdebruiteeW= wiener2d(xb, sigma);

EQMSW=mean((x(:)-imdebruiteeW(:)).^2);
disp('L''erreur quadratique moyen qu''on obtient c''est')
EQMSW

figure(); image(uint8(imdebruiteeW)); axis image; colormap(gray(256)); axis off; 
title('Filtrage Wiener');



%% Commentaire
% Dans la section pr�cedante on a utilis� l'estimateur de l'�cart-type bas� sur la m�diane;
% en r�gardant la valeur de l'�cart-type estim�, on constate que cette
% valeur es raisonablement proche � celui du vrai �cart-type, et pour cette
% raison la performance des m�thodes de d�bruitage en utilisant l'�cart
% type estim� est bien proche � cela o� on avait utilis� la
% connaisance du vrai �cart type (en terms visuels et en terms d'erreur
% quadratique moyen). 




