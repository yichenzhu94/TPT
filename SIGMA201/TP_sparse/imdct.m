function x = imdct(y,L)
% IMDCT Inverse Modified Discrete Cosine Transform
%   X = IMDCT(C,L) returns the Inverse Modified Discrete Cosine Transform
%   with fixed window size L of the vector of coefficients C.
%
%   The window is based on a sine window.
%
%   See also MDCT

%Input must be a vector
if ~isvector(y)
    error 'Input must be a vector';
end
y = y(:);

%Signal length
N = length(y);

%Number of frequency channels
K = L/2;

%Test length
if mod(N,K)~=0
    error 'Input length must be a multiple of the half of the window size'
end

%Number of frames
P = N/K;
if P<2
    error 'Signal too short';
end

%Reshape
temp = y;
y = zeros(L,P);
y(1:K,:) = reshape(temp,K,P);

%Pre-twiddle
y = y .* repmat(exp(1i*2*pi*(0:L-1)'*((L/2+1)/2)/L),1,P);

%IFFT
x = ifft(y);

%Post-twiddle
x = x .* repmat(exp((1/2)*1i*2*pi*((0:L-1)'+((L/2+1)/2))/(L)),1,P);

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

%Real part and scaling
x = sqrt(2/K)*L*real(x);

%Overlap and add
adv  = P*K;
sidx = (1:(P*L)).';
fidx = adv*(0:(P-1));
fidx = fidx(ones(L,1),:);
fidx = fidx(:);
lidx = sidx + fidx;
zlidx = lidx-1;
b = fix(zlidx./(N+K)) + 1;
a = zlidx - (N+K).*(b-1) + 1;
sp = sparse(a,b,x,(N+K),P);
x = full(sum(sp,2));

%Cut edges
x = x(K/2+1:end-K/2);
