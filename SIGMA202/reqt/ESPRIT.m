function [deltak fk]= ESPRIT(x, n, K);

%generate a Hankel matrix X
N=length(x);
l=N+1-n;
X= hankel(x(1:n),x(n:N));
%calcul de la matrice de correlation
R=(1/l)*X*X';
%estimation de l'espace signal
[U1 lambda U2]= svd(R);
W=U1(:,1:K);
%estimation des frequences et des facteurs d'amortissement
Wdown=W(1:end-1,:);
Wup=W(2:end,:);
Phi=pinv(Wdown)*Wup;%pinv() pour calcul de pseudo inverse
Zk=eig(Phi);
deltak=log(abs(Zk));
fk=1/2/pi*angle(Zk);

end

