function [ DSP ] = durbin(X,p,q)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
N = length(X);
variance1 = var(X);
r = autocorr(X,length(X)-1);
a = levinson(r);

% model2 = arima('Constant',a(1),'AR',{a(2),a(p+1)},'Variance',variance1);
% X2 = simulate(model2,length(X));
Z = variance1*randn(1,N);
X2 = filter(1,a,Z);

variance2 = var(X2);
r2 = autocorr(X2,length(X2)-1);
a2 = levinson(r2,q);
variance3 = variance1/variance2;
DSP = variance3^2 ./ (abs(fft(a,N)).^2).*(abs(fft(a2,N)).^2);
end