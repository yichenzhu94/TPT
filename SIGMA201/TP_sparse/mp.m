function [s, err_mse]=mp(x,P,Pt,m,max_iter,verbose)
% mp: Matching Pursuit algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
% [s, err_mse]=mp(x,P,Pt,m,'option_name','option_value')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%   Mandatory:
%       x        Observation vector to be decomposed
%       P        is a function handle (type "help function_format"
%                       for more information)
%                       Also requires specification of P_trans option.
%       Pt       is a function handle for P transpose
%       m        length of s
%       max_iter number of iterations
%       verbose  true or false to allow algorithm progress to be displayed.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%       s        Solution vector
%       err_mse  Vector containing mse of approximation error for each
%                iteration
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright does exist but is not given for education purpose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Default values and initialisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = x(:);  % make it a column vector
n = length(x);

%%%%%%%%%%%%%%%%%%%%%%%%%
%    Default values
%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 5
    max_iter = 100;
end

if nargin < 6
    verbose = false;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Initialisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialisation
IN       = [];
Residual = x;
s        = zeros(m,1);
err_mse  = zeros(max_iter,1);
done     = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Main algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if verbose
   display('Main iterations...')
end

% TO DO : Initialize inner product, variable initialisation

iter = 1;
err_mse(1)=x'*x/n;

while ~done

    coefs = Pt(Residual);
    % TO DO :  Find new element and add its index I to IN
    [MaxCoef, I] = max(abs(coefs));
    IN(iter) = I;
    % TO DO :  Update coefficient s(I) 
    s(I) = s(I) + coefs(I);

    % TO DO :  Update Residual and inner products
    tmp = zeros(m,1);
    tmp(I) = coefs(I);% Prend le seul coeff qui nous intéresse
    Residual = Residual - P(tmp);

    % TO DO :  Computate new norm of Residual (err_mse)
    % Correction
    ERR = norm(Residual,2).^2;
    err_mse(iter) = ERR;

    if verbose
        display(sprintf('Iteration %i. --- %i iterations to go',iter,max_iter-iter))
    end

    % TO DO :  Define here a smart stop criteria
    if iter >= max_iter
        done = true;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    If not done, take another round
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~done
        iter=iter+1;
        oldERR=ERR;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Only return as many elements as iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

err_mse = err_mse(1:iter);

if verbose
   display('Done')
end
