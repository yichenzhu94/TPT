function [ x_est ] = remove_echo ( n,p,x,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

u = 0.005;
g = zeros(p,1);
nb_iter = n-p;
x_est = zeros(n,1);

for i = p+1:nb_iter
    e = x(i) - y(i-p+1:i)*g;
    tmp = u*e*y(i-p+1:i);
    g = g + tmp';
    x_est(i) = y(i-p+1:i)*g;
end


end