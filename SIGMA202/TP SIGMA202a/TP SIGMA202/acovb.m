function gamma = acovb(X)

X = X - mean(X);
n = length(X);
m = 2*n-1;
I  = abs(fft(X,m)).^2/n;
gamma = real(ifft(I));
gamma = gamma(1:n);

end