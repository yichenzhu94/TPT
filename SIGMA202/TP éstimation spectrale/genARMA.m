function [ X ] = genARMA( coeffAR,coeffMA,N,variance )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% p = length(coeffAR);
% q = length(coeffMA);

model = arima('Constant',0,'AR',{coeffAR(1),coeffAR(2)},'MA',{coeffMA(1),coeffMA(2)},'Variance',variance);
X = simulate(model,N);

% synthèse avec la méthode de filtrage
% Z = variance*randn(1,N);
% 
% X = filter(coeffMA,coeffAR,Z);

end