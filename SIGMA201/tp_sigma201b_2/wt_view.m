function X = wt_view(X,nStep)
%WT_VIEW Shows WT images
%  X = WT_VIEW(IMG,NLEV)
%  Show an image with NLEV levels of Wavelet decomposition
%  IMG is the matrix of DWT coefficients.
%
% (C) 2005-2016 Marco Cagnazzo - TELECOM-ParisTech
%

X = wtv(X,nStep);

