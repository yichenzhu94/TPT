clear all
close all
fftw('planner', 'estimate');

% dictionary sizes (in samples)
sizes = [8192];
maxsizes = max(sizes);

% load data
[s, Fs] = audioread('glockenspiel.wav');
s_length = 3*16384;
% s_length = length(s);

s = [zeros(maxsizes,1); s(1:s_length,1); zeros(maxsizes,1)];

% declare MDCT multiscale transform & inverse transform functions
PhiT = @(s) MdctOp(s,sizes);
Phi = @(x) MdctOp_transpose(x,sizes);

lambda = 0.1;

% Launch convex_l1 with 50 iterations
m = length(s)*length(sizes);
[x_l1, pobj] = convex_l1(s,Phi,PhiT,m,lambda,50,true);

% TO DO : What is the sparsity of x_l1 ?
sparcity = sum(x_l1==0)/length(x_l1);
% See how we have done
s_est_l1 = Phi(x_l1);

figure
subplot(211)
plot(s);
subplot(212)
plot(s_est_l1)

figure
plot(pobj);
xlabel('Iterations')
