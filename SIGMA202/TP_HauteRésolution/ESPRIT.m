function [ delta,f ] = ESPRIT( x,n,K )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

N = length(x);
l = N-n+1;
c = x(1:n);
r = x(n:N);
X = hankel(c,r);
RxxChp = (1/l)*X*X';

[U1,Lambda,U2] = svd(RxxChp);
W = U1(:,1:K);
Wdown = W(1:end-1,:);
Wup = W(2:end,:);
Phi = pinv(Wdown)*Wup;
pole = eig(Phi);
delta = log(abs(pole));
f = 1/2/pi*angle(pole);

end

