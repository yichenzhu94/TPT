%Welsh
function periodoWelsh=welsh(X,L,alpha)
%alpha: pourcentage de recouvrement
n = fix(length(X)/L);
periodoW = zeros(L/alpha,n);
T = n*alpha;
K = (L/alpha)-1;
V = hann(n)';
for i = 1:K
    P = mean(abs(V.^2));
    periodoW(i,:) = (abs((fft(V.*X(T*(i-1)+1:T*(i-1)+n)))).^2)/(n*P);
end
periodoWelsh = mean(periodoW);
end