function [ s ] = prox( x,seuil )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if x >= seuil
            s = x -seuil;
        elseif -seuil < x < seuil
            s = 0;
        else
            s = x + seuil;
    end

end