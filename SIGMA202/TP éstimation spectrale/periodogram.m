%periodogramme standard
function [periodo]=periodogram(X)
    periodo = power(abs((fft(X))),2)/length(X);
end