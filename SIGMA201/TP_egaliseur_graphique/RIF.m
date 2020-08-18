clear all
close all

Fe = 10000;
Fc = 900;
Vc = Fc/Fe;

v = -0.5:0.001:0.5;
H = zeros(1,length(v));
Left = (-Vc+0.5)/0.001+1;
Right = (Vc+0.5)/0.001+1;
H(Left:Right)=ones(1,2*(length(v)-1)*Vc+1);
figure
plot(v,H(1,:));

h = zeros(1,length(v));
h = ifftshift(abs(ifft(H)));
figure
plot(h);