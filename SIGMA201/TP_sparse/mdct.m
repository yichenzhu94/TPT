function y = mdct(x,L)
% MDCT Modified Discrete Cosine Transform
%   C = MDCT(X,L) returns the Modified Discrete Cosine Transform with fixed
%   window size L of the signal X.
%
%   The window is based on a sine window.
%
%   See also IMDCT

%Input must be a vector
if ~isvector(x)
    error 'Input must be a vector';
end
x = x(:);

%Signal length
N = length(x);

%Number of frequency channels
K = L/2;

%Test length
if mod(N,K)~=0
    error 'Input length must be a multiple of the half of the window size'
end

%Pad edges with zeros
x = [zeros(L/4,1);x;zeros(L/4,1)];

%Number of frames
P = N/K;
if P<2
    error 'Signal too short';
end

%Framing
temp = x;
x = zeros(L,P);
fidx = K*(0:(P-1));
fidx = fidx(ones(L,1),:);
sidx = (1:L)';
sidx = sidx(:,ones(1,P));
x(:) = temp(fidx+sidx);

%Windowing
wLong = sin(pi*((0:L-1)'+1/2)/L);
wEdgeL = wLong;
wEdgeL(1:L/4) = 0;
wEdgeL(L/4+1:L/2) = 1;
wEdgeR = wLong;
wEdgeR(L/2+1:L/2+L/4) = 1;
wEdgeR(L/2+L/4+1:L) = 0;
x(:,1) = x(:,1).*wEdgeL;
x(:,2:end-1) = x(:,2:end-1).*repmat(wLong,1,P-2);
x(:,end) = x(:,end).*wEdgeR;

%Pre-twiddle
x = x .* repmat( exp(-1i*pi*(0:L-1)'/L) ,1,P);

%FFT
y = fft(x);

%Post-twiddle
y = y(1:L/2,:) .* repmat(exp(-1i*pi*(L/2+1)*(0.5:L/2-0.5)'/L),1,P);

%Real part and scaling
y = sqrt(2/K)*real(y(:));
