function L = lipschitz_estimation(Phi,PhiT,m)

%   LIPSCHITZ_ESTIMATION  Estimating the lipschitz constant based on a 
%                   power iteration method
%
%       L = lipschitz_estimation(Phi,PhiT,params,options)
%
%   Output parameter
%
%       L : estimated lipschitz constant
%
%   SYNTAX
%       L = lipschitz_estimation(Phi,PhiT,m)
%
%   Created by Alexandre Gramfort, 2013

L = 0;
Lold = 1;
it = 0;
maxit = 500;
w = randn(m,1);

while it < maxit && abs(L - Lold)/abs(L) > 0.01;
    disp(['Lipschitz estimation: iteration = ',num2str(it)])
    Lold = L;
    it = it+1;
    w = Phi(PhiT(w));
    L = norm(w(:),'inf');
    w = w/L;
end
