clear all
close all


H = 1024; % nbre de points de la covariance
n = 2*H-1; % nbre de points du processus
X = randn(1,n);
% Z = randn(1,n); %Pour l'AR(1) avec racine du poly = lambda
% lambda=2;
% X = filter(1,poly(1/lambda),Z);
u = sum(X)/n;

I = (abs(fftshift(fft(X-u)))).^2;
figure
plot(I)

gamma = acovb(I);
figure
plot(gamma)

estm = zeros(n);
for k =1:n
    X = randn(1,k);
    u = sum(X)/k;
    I = ((abs(fftshift(fft(X-u)))).^2)/k;
    estm(k) = var(I);
end
figure
plot(estm)