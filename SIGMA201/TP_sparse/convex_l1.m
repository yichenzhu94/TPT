function [s, pobj]=convex_l1(x,P,Pt,m,lambda,max_iter,verbose)
% convex_l1: L1 Basis Pursuit Densoining (BPDN) algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
% [s, pobj] = convex_l1(x,P,m,'option_name','option_value')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
%       x        Observation vector to be decomposed
%       P        is a function handle (type "help function_format"
%                       for more information)
%                       Also requires specification of P_trans option.
%       Pt       is a function handle for P transpose
%       m        length of s
%       lambda   regularization parameter
%       max_iter number of iterations
%       verbose  true or false
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output:
%    s              Solution vector
%    pobj           Cost function to minimize at each iteration
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright Alexandre Gramfort 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = x(:);  % make it a column vector

s = zeros(m,1);
pobj = zeros(max_iter,1);

if nargin < 6
    max_iter = 1000;
end

if nargin < 7
    verbose = false;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Main algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if verbose
   display('Main iterations...')
end

L = 1.1 * lipschitz_estimation(P,Pt,m);
u = 1/L;
seuil = u*lambda;

for k=1:max_iter

    % TO DO :  Write forward-backward ie. gradient step
    % and the L1 proximity operator ie. soft thresholding
    
        s_tmp = s + u.*Pt(x-P(s));
        s = SoftThresh(s_tmp,seuil);
        
    pobj_k = 0.5 * norm(x - P(s), 'fro')^2 + lambda * sum(abs(s(:)));
    fprintf('Iteration %d: cost function = %f\n',k,pobj_k);
    pobj(k) = pobj_k;

end

if verbose
   display('Done')
end
