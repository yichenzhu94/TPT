%% TP compression d'image
close all; 
clear all; 
clc

%% Charger une image et l'afficher
x= double(imread('lena.pgm'));
bpp = 8; % bits per pixel
dyn = 2^bpp;
[rows, cols] = size(x);
%% Transformée "full-frame"

T = dct2(x);
figure; 
imagesc(log10(abs(T))); 
axis image; 
colorbar; 
axis off
title('Transformée TCD de l''image, log_{10}');
set(gcf, 'Position', [619   387   682   603]);


%% Transformée par blocs
blockSize = 16;
T_DCT = blkproc(x, [blockSize blockSize], @dct2);
figure; 
imagesc(log(abs(T_DCT))); 
colorbar; 
title(sprintf('Transformée TCD de l''image, log_{10}, blocs %d x %d',...
    blockSize,blockSize));
% Affichage des limites des blocs
ax = gca; 
ax.XTick = [0:blockSize:rows]; 
ax.YTick = [0:blockSize:rows];
ax.XTickLabel =''; 
ax.YTickLabel='';  
grid on;  

%% Calcul des variances par bande
 
numBlocks = rows*cols/ blockSize / blockSize;
cube = zeros(blockSize, blockSize, numBlocks);

% Calcul du cube
n=0;
for r = 0:blockSize:rows-1,
    for c = 0:blockSize:cols-1,
        n=n+1;
        block = T_DCT(r+1:r+blockSize, c+1:c+blockSize);
        cube(:,:,n) = block;
    end
end
%% Affichage du cube des coeff DCT
subSampling=20; 
nSlices = 5;
xslice = [blockSize];
yslice = [blockSize];
zslice = round(linspace(1, numBlocks/subSampling, nSlices));
slice(log10(abs(cube(:,:,1:subSampling:numBlocks))),xslice,yslice,zslice);

%% Calcul des variances
vars =zeros(blockSize);
for i=1:blockSize,
    for j = 1:blockSize,
        tmp = cube(i,j,:);
        vars(i,j) = var(tmp(:));
    end
end

figure; 
imagesc(log10(vars));
colorbar;
axis image;
title('Variances des coefficients TCD, log_{10}');

codingGain = block.^2/vars.^2;% C'est quoi le coding gain
CG_dB = 10*log10(codingGain);
fprintf('Le gain de codage est %4.2f dB\n', CG_dB);

%% Affichage image compressée

delta = 10;
T_DCT = blockproc(x, [blockSize blockSize], @dct2);
TQ = qu_dz(T_DCT,delta) ;
XQ = blkproc(TQ, [blockSize blockSize], @idct2);

PSNR_X = ???;
PSNR_T = ???;
fprintf('PSNR sur X: %5.2f\nPSNR sur T: %5.2f\n', PSNR_X,PSNR_T);

figure; image(uint8(XQ)); axis image; colormap(gray(256)); axis off; 

title (sprintf('Image avec quantification de la TCD. \\Delta = %d - PSNR: %5.2f',...
    delta, PSNR_T));
set(gcf, 'Position', [619   387   682   603]);

%% Courbe RD transformée et quantification 

% Trasformée par blocs
blockSize = 16;
T_DCT = blkproc(x, [blockSize blockSize], @dct2);


DELTA= 128:-2:1;
R_T = zeros(size(DELTA));
D_T = zeros(size(DELTA));
PSNR_T = zeros(size(DELTA));
for iDelta = 1:numel(DELTA),
    delta = DELTA(iDelta);    
    TQ = qu_dz(???)
    h = hist(???);    
    pmf = h/sum(h);
    R_T(iDelta) = pmfEntr(pmf); 
    D_T(iDelta)=  mean( ??? );
    PSNR_T(iDelta) = 10*log10(dyn^2/ D_T(iDelta) );
end

save RD_DCT_stat R_T D_T PSNR_T
%%
load RD_stat
figure; h1=plot(R_PQ_E,D_PQ, R_QU_E,D_QU, R_T,D_T);
xlabel('Rate [bpp]'); ylabel('D - MSE');  legend('QP', 'QU', 'QT'); 

figure; h2=plot(R_PQ_E,PSNR_PQ, R_QU_E,PSNR_QU, R_T,PSNR_T);
xlabel('Rate [bpp]'); ylabel('PSNR [dB]');  
legend('QP', 'QU', 'QT', 'Location','SouthEast'); 

set([h1 h2], 'linewidth', 2)


