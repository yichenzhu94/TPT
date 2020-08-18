function [alpha amp phi]= LeastSquares(x, deltak, fk, N, K)

%estimation des amplitudes et des phases
Z=(deltak+j*2*pi*fk);
t=0:N-1;
%eviter d'utiliser une boucle
VN=exp(t'*Z.');
alpha=pinv(VN)*x;
amp=abs(alpha);
phi=angle(alpha);

end 