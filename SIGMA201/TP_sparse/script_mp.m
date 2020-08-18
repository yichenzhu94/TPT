clear all
close all
fftw('planner', 'estimate');

% dictionary sizes (in samples)
sizes = [128 1024 8192]; % la taille de MDCT
maxsizes = max(sizes);

% load data
[s, Fs] = audioread('glockenspiel.wav');
s_length= 3*16384;
% s_length = length(s);

s = [zeros(maxsizes,1); s(1:s_length,1); zeros(maxsizes,1)];

% declare MDCT multiscale transform & inverse transform functions
PhiT = @(s) MdctOp(s,sizes);
Phi = @(x) MdctOp_transpose(x,sizes);
x = MdctOp(s,sizes);
figure
hist(x,64);

% Launch mp 100 iterations
m = length(s)*length(sizes);
max_iter = 100;
verbose=true;
[x_mp, err_mse_mp] = mp(s,Phi,PhiT,m,max_iter,verbose);

%% See how we have done
s_est_mp = Phi(x_mp);

figure
subplot(211)
plot(s);
subplot(212)
plot(s_est_mp)

figure
plot(err_mse_mp);
