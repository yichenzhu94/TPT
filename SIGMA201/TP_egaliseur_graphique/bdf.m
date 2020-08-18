clear all 
close all

M = 32;
v = 0:0.001:1/2*pi*M;
H = zeros(M,length(v));
H(1,1:length(v)/2)=ones(1,length(v)/2);
figure
plot(v,H(1,:));

h = zeros(M,length(v));
h(1,:) = ifftshift(ifft(H(1,:)));
figure
f = -0.5:1/length(v):0.5;
plot(f(1:length(f)-1),abs(h(1,:)));

for k = 1:M-1
    for n = 1:length(v)
        h(k,n) = h(1,n)*exp(i*2*pi*k*n/M);
    end
    H(k,:) = fftshift(fft(h(k,:)));
end

figure
plot(v,abs(H(2,:)));
figure
plot(v,abs(H(3,:)));
figure
plot(v,abs(H(4,:)));