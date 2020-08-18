function xw  = wiener2d(y,sb)
%  xw  = wiener2d(y,sb)
% y: image bruitee
% sb: ecart-type du bruit suppose blanc
% xw: image filtree

[N,M] = size(y);
my = mean(y(:));
Y = fft2(y-my);
S = abs(Y).^2/(N*M);

% filtre de Wiener
H = max(S-sb^2,0)./(S+eps);
Y = H.*Y;
xw = real(ifft2(Y)) + my;