function xq = qu_dz(x,delta)
% QU_DZ Dead-zone uniform quantization
%

%% Encoder
ind = fix(x/delta);

%% Decoder
xq = delta*ind  + (ind~=0).*sign(x).*delta/2; 