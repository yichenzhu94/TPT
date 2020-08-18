function [  ] = MUSIC( x,n,K )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
N = length(x);
l = N-n+1;
c = x(1:n);
r = x(n:N);
X = hankel(c,r);
RxxChp = (1/l)*X*X';
[U1,Lambda,U2] = svd(RxxChp);
Wortho = U1(:,K+1:end);

f = 0:0.01:2;
delta = -0.1:0.001:0.1;
for i = 1:length(f)
    for j = 1:length(delta)
        z(i,j) = exp(delta(j)+1i*2*pi*f(i));
        vnz = zeros(n,1);
        for k = 1:n
            vnz(k) = z(i,j)^(k-1);
        end
    P(i,j) = 1/(norm(Wortho'*vnz,2))^2;
    end
end

surf(log(P));

end

