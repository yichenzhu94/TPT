%% TP compression d'image
close all; 
clear all; 
clc

global verbose
verbose = 0;   % Definit le niveau d'affichage des fonctions
%% Charger une image et l'afficher
x= double(imread('lena.pgm'));
bpp = 8; % bits per pixel
dyn = 2^bpp;


%% Entrée/sortie du QU dead-zone

bitrate = 4;
delta = 2^(bpp+1-bitrate);
in=-dyn+1:dyn-1;
figure; 
plot(in,qu_dz(in,delta),'o'); 
hold on
line([-dyn dyn], [0 0]); 
line([0 0], [-dyn dyn]);
title(sprintf('Relation entrée/sortie du QU centré à %d bit', bitrate));
axis([min(in) max(in)  min(in) max(in)]);
xlabel('x'); 
ylabel('Q(x)')


%% Quantification prédictive

% Codage et décodage
delta = 3;
[ind, filter, reconstr, predErrImg, qPredErrImg] = qp_dz(x,delta) ;
XQ = reconstruct(ind,delta,filter);
if isequal(XQ,reconstr)
    fprintf('Le codeur et le décodeur reconstruisent la même image\n');
end

% Affichage
figure;
image(uint8(XQ));
axis image;
colormap(gray(256));
axis off;
PSNR_P = 10*log10(dyn^2/ mean( (x(:)-XQ(:)).^2 ));
title (sprintf('Image quantifiée avec \\Delta = %d - PSNR: %5.2f',...
    delta, PSNR_P));

figure;
imagesc((predErrImg));
axis image;
axis off;
colorbar;
title('Erreur de prédiction'); 

% Calcul EQM
eqm1 = mean2((predErrImg-qPredErrImg).^2);
eqm2 = mean2((x-XQ).^2);

fprintf('Bruit de quantification sur l''erreur de prédiction : %6.2f\n',eqm1);
fprintf('Bruit de quantification sur l''image : %21.2f\n',eqm2);

%% Histogramme de l'erreur de prédiction
predErrImgStat=predErrImg(2:end); % La première valeure n'est pas prise en compte
figure; 
hist(predErrImgStat(:), -dyn:0.5:dyn)
title('Histogramme de l''erreur de prédiction');%

% Histogramme de l'erreur de prédiction quantifié
qPredErrImgStat=qPredErrImg(2:end); % La première valeure n'est pas prise en compte
figure; 
hist(qPredErrImgStat(:), -dyn:0.5:dyn)
title('Histogramme de l''erreur de prédiction quantifié');

%% Variances et gain de prédiction
sigmaY2 = var(qPredErrImgStat);
sigmaX2 = var(predErrImgStat);
GP = 10*log10((sigmaX2.^2)/(sigmaY2.^2));
fprintf('VAR X: %7.2f\nVAR Y: %7.2f\nGP:    %7.2f dB\n',sigmaX2,sigmaY2,GP);
 
%% Courbe RD de la QP
DELTA= [128:-10:8 4 2 1] ; % 
R_PQ = zeros(size(DELTA));
D_PQ = zeros(size(DELTA));
PSNR_PQ = zeros(size(DELTA));
R_QU = zeros(size(DELTA));
D_QU = zeros(size(DELTA));
PSNR_QU = zeros(size(DELTA));
R_PQ_E = zeros(size(DELTA)); % 'E' pour entropie
R_QU_E =zeros(size(DELTA)); %  
t0=clock();
for iDelta = 1:numel(DELTA),
    delta = DELTA(iDelta);
    fprintf('Coding %3d/%3d in progress...',iDelta,numel(DELTA));
    %QU
    t1= clock();
    R_QU(iDelta) = bpp-log2(delta);
    XQ = qu(x,delta) ;
    h = hist(XQ(:), min(XQ(:)):max(XQ(:)));
    pmf = h/sum(h);
    R_QU_E(iDelta) = pmfEntr(pmf); 
    D_QU(iDelta)=  mean((x(:)-XQ(:)).^2);
    PSNR_QU(iDelta) = 10*log10(dyn^2/ D_QU(iDelta) );
    
    %PQ
    R_PQ(iDelta) = bpp-log2(delta);
    [ind, filter] = qp_dz(x,delta);
    XQ = reconstruct(ind,delta,filter);
    %XQ0=XQ-XQ2;
    h = hist(XQ(:), min(XQ(:)):max(XQ(:)));
    pmf = h/sum(h);
    R_PQ_E(iDelta) = pmfEntr(pmf); 
    D_PQ(iDelta)= mean((x(:)-XQ(:)).^2);
    PSNR_PQ(iDelta) = 10*log10(dyn^2/ D_PQ(iDelta));
    
    % Temps execution
    t2=clock;
    ET = etime(t2,t1); % temps de l'iteration courante
    EG = etime(t2,t0); % temps globale
    fprintf(' completed in %5.2fs, expected remaining time %5.2fs\n', ET, EG*(numel(DELTA)-iDelta)/iDelta);
end
 fprintf('Completed in %5.2fs\n', EG);
 
%% Figures
figure; h=plot(R_PQ,D_PQ, R_QU,D_QU); 
xlabel('Rate - bpp, codage longeur fixe'); ylabel('D - MSE');
legend('QP', 'QU', 'Location', 'NorthEast');
title('Courbe R-D'); set(h,'LineWidth',2);
figure; h=plot(R_PQ,PSNR_PQ, R_QU,PSNR_QU); 
xlabel('Rate - bpp, codage longeur fixe'); ylabel('PSNR - dB');
legend('QP', 'QU', 'Location', 'SouthEast');
title('Courbe R-PSNR'); set(h,'LineWidth',2);
%% Courbe RD avec estimation basée sur l'entropie
figure; h=plot(R_PQ_E,D_PQ, R_QU_E,D_QU); 
xlabel('Rate (Entropie) - bpp'); ylabel('D - MSE');
legend('QP', 'QU');
title('Courbe R-D, débit estimé par l''entropie'); set(h,'LineWidth',2);
figure; h=plot(R_PQ_E,PSNR_PQ, R_QU_E,PSNR_QU); 
xlabel('Rate (Entropie) - bpp'); ylabel('PSNR - dB');
legend('QP', 'QU', 'Location', 'SouthEast');
title('Courbe R-PSNR, débit estimé par l''entropie'); set(h,'LineWidth',2);
%%
save RD_stat R_QU_E D_QU  PSNR_QU  R_PQ_E   D_PQ   PSNR_PQ