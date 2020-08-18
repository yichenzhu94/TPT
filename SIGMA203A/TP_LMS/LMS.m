function [ s_est,eqm ] = LMS( n,p,x,y,s )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

u = 0.01;
g = zeros(p,1);
nb_iter = n-p;
x_est = zeros(n,1);
s_est = zeros(n,1);

for i = p+1:nb_iter
    e = x(i) - y(i-p+1:i)*g;
    tmp = u*e*y(i-p+1:i);
    g = g + tmp';
    x_est(i) = y(i-p+1:i)*g;
    s_est(i) = s(i) + x(i) - x_est(i);
    eqm(i) = mean((s(p+1:i)-s_est(p+1:i)').^2);
end

eqm = eqm(p+1:nb_iter);

end

