function ffondamentale = fondamentale(y, Fs, method)

%This method searches the peaks of y's periodogram. It looks for the
%greatest peak and returns the value of the frequency at which this peak
%occurs. 

if  method==1

corr1= xcorr(y,y);
position = floor(length(corr1)/2+1);

pks = findpeaks(corr1(position+1:end));
position2= find(corr1(position+1:end)==max(pks));

ecart= position2;
ffondamentale= Fs/ecart;
    
else

x=reshape(y,[length(y) 1]);
N=floor(0.7*length(x));      % Window size of analysed signal (only one window of signal is analysed)

H=4;                  % H = nombre de versions compressées

%Minimal frequency resolution
dF_min=Fs/N;             

%Window
w=hamming(N);

%Beginning of signal (e.g. attack) is discarded
offset=floor(0.1*length(x));
xw=x(offset+1:offset+N).*w;    %xw est la fenetre de signal analysée

%Minimal number of data points to satisfy the minimal frequency resolution
Nfft_min=Fs/dF_min;

%compute the smallest power of two that satisfies the minimal frequency resolution for FFT
p = nextpow2(Nfft_min);
Nfft=2^p;

%calcul FFT
Xk=fft(xw,Nfft);

%normalisation
Xk=Xk/max(abs(Xk)+eps);

L= length(Xk);
XK=zeros(L,H);

XK(:,1)=Xk;
for j=2:H
    XK(:,j)=[downsample(Xk,j); zeros(L-length(downsample(Xk,j)),1)];
end


P=XK(:,1);

for j=2:H
    
    P= P.*XK(:,j);
    
end

P=P(1:length(downsample(Xk,H)),:);

[m,n]=findpeaks(abs(P), 'SORTSTR', 'descend');

Maximum= n(1);

ffondamentale= ((Maximum/Nfft)*Fs);

end

end
    
