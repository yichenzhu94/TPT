function P=MUSIC(x, n, K)

%estimation de l'espace signal
N=length(x);
l=N+1-n;
X= hankel(x(1:n),x(n:N));
R=(1/l)*X*X';
[U1 lambda U2]= svd(R);
W=U1(:,1:K);

Wright=U1(:,K+1:n);

%definir le plan de f et delta
f=0:0.01:2;
delta=-0.1:0.002:0.1;
%pour chaque point dans le plan, calcul de P(z)
for i=1:length(f)
    for ii=1:length(delta)
        z(i,ii)=exp(delta(ii)+j*2*pi*f(i));
        vnz=zeros(n,1);
        for k=1:n
            vnz(k)=z(i,ii)^(k-1);
        end
        %vnz=vnz';
        P(i,ii)=1/(norm(Wright' * vnz, 2))^2;
    end
end

end