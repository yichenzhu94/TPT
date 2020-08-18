function xq = qu(x,delta)
% QU Uniform quantization
%

%% Encoder
ind = floor(x/delta); % delta permet changer la qualité de la 
% quantification, plus delta est petit, plus la quantification est préise
% mais plus coûteuse aussi

%% Decoder
xq = delta*ind + (delta/2); % delta/2 permet de résoudre le problème de 
% décalage des intervalles de quantification sur l'axe de Q(x), sinon le 
% zéro n'est pas centré