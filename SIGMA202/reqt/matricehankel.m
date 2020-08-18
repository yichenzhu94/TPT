function [Rxxhat X]= matricehankel(x,n);

N=length(x);
l=N+1-n;
c=x(1:n);
r=x(n:N);
X=hankel(c,r);
Rxxhat=(1/l)*X*X';

end