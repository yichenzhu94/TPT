clear all
close all

n = 1000;
p = 4;
[X,phi] = genAR(p,n);
u = sum(X)/n;
gamma = acovb(X);
gamma = gamma(1:p+1);
gamma_p = toeplitz(gamma);
M = zeros(1,p+1);
M(1) = 1;
v = inv(gamma_p)*M';
A= [1];
filtre = cat(1,A,-phi');
fz = 2*pi/v(1);
f_filtre = (abs(fftshift(fft(filtre,1024)))).^(-2);
fx = fz*f_filtre;
filtre1 = cat(1,A,v(2:p+1));
f_filtre1 = (abs(fftshift(fft(filtre1,1024)))).^(-2);
fx1 = fz*f_filtre1;
figure
semilogy(fx)
hold on
semilogy(fx1)