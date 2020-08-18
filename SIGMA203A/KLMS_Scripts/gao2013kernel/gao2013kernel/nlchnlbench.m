%===============================================================================
%  Three-state nonlinear channel benchmark
%
%  [data,d,noise] = nlchnlbench(snr,len0,len1,len2,option);
%
%  Input:
%  snr    : SNR of sequence d (ex: cur_snr = 15)
%  len0   : length of the sequence d (ex: len0 = 9e4)
%  len1   : first interrupt position in d (ex: len1 = 3e4)
%  len2   : second interrupt position in d (ex: len2 = 6e4)
%  option :  
%
%  Output:
%  data  : input data
%  d     : desired output sequence
%  noise : noise added to d
%
%  Copyright (c) 2012-2022 by Wei GAO referenced by P. Bouboulis.
%===============================================================================

function [data,d,noise] = nlchnlbench(cur_snr,len0,len1,len2,option)

L = 5;
D = 2;
len0 = len0 + L - 1;
f = 0.5e-3;
tn = 1 : len0;
h = [-0.8 0.7];

%input signal s0 s1 s2
std_signal = 1;
mean_signal0 = -4;
mean_signal1 = 0;
mean_signal2 = 4;
mean_signal = zeros(1,len0);
t = zeros(len0,1);
r = zeros(len0,1);

%gaussian noise n
std_noise = sqrt(std_signal^2 / (10^(cur_snr/10)));
noise = std_noise * randn(1,len0);

if option == 0
    s0 = std_signal * randn(1,len1);
    s0 = s0-mean(s0) + mean_signal0;
    s1 = std_signal * randn(1,len2);
    s1 = s1 - mean(s1) + mean_signal1;
    s2 = std_signal * randn(1,len0);
    s2 = s2 - mean(s2) + mean_signal2;
    
    %linear channel and then non linear channel without memory
    p = 2; %how many values of the signal the channel takes
    for n = 1 : p
        t(n) = s0(n);
    end;

    for n = p + 1 : len1
        t(n)= h(1) * s0(n) + h(2) * s0(n-1);
        r(n)= t(n) + 0.25 * t(n)^2  + 0.11 * t(n)^3  + noise(n);
    end;

    for n = len1 + 1 : len2
        t(n) = h(1) * s1(n) + h(2) * s1(n-1);
        r(n) = t(n) + 0.25 * t(n)^2  + 0.11 * t(n)^3  + noise(n);
    end;

    for n = len2 + 1 : len0
        t(n) = h(1) * s2(n) + h(2) * s2(n-1);
        r(n) = t(n) + 0.25 * t(n)^2  + 0.11 *t(n)^3  + noise(n);
    end;

    s = [s0(p + 1 : len1) s1(len1 + 1 : len2) s2(len2 + 1 : len0)];
elseif option == 1
    for n = 1 : len0
        mean_signal(n) = tn(n)^(1/4) * sin(2*pi*f*tn(n));%
    end
    s = std_signal * randn(1,len0);
    s = s - mean(s) + mean_signal;
    
    %linear channel and then non linear channel without memory
    p = 2; %how many values of the signal the channel takes
    for n = 1 : p
        t(n) = s(n);
    end
    for n = p + 1 : len0
        t(n) = h(1) * s(n) + h(2) * s(n-1);
        r(n) = t(n) + (0.25) * t(n)^2  + (0.11) * t(n)^3  + noise(n);
    end
    
end

for n = L - D : len0 - D
        d(n-2) = s(n);
end;

data = [r(1 : len0 - L + 1) r(2 : len0 - L + 2) r(3 : len0 - L + 3) r(4 : len0 - L + 4) r(5 : len0 - L + 5)]; 

return;