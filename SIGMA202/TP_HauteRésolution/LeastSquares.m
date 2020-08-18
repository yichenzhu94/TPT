function [ a,phi ] = LeastSquares( x,delta,f )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

N = length(x);
z = delta + i*2*pi*f;
T = 0:N-1;
lnVN = T'*z.';
VN = exp(lnVN);
a = pinv(VN)*x;
phi = angle(a);
a = abs(a);

end

