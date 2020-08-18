function xq = qu(x,delta)
% QU Uniform quantization
%

%% Encoder
ind = floor(x/delta); % delta permet changer la qualit� de la 
% quantification, plus delta est petit, plus la quantification est pr�ise
% mais plus co�teuse aussi

%% Decoder
xq = delta*ind + (delta/2); % delta/2 permet de r�soudre le probl�me de 
% d�calage des intervalles de quantification sur l'axe de Q(x), sinon le 
% z�ro n'est pas centr�