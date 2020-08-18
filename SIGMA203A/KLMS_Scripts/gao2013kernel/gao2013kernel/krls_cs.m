%===============================================================================
% The KRLS algorithm of Engel, Mannor and Meir based on coherence sparsification.
% contact: cedric.richard@unice.fr
%
% Y. Engel, S. Mannor, and R. Meir, "Kernel recursive least squares,"
% IEEE Transactions on Signal Processing, vol. 52, no. 8, pp. 2275-2285, 2004.
%
% This method performs kernel-based adaptive filtering of order-recursive RLS
% type. See the above-mentionned reference for more details.
%
% function [err,tdict,ndict,ndict_t]=krls(v,d,tresh,ker,p1);
%
% inputs of the function
% v     : matrix of the inputs of the filter, each row corresponding
%         to the input values at a given time instant.
% d     : row vector of desired outputs.
% tresh : novelty threshold in [0, 1]. If the novelty coefficient of an input v(n)
%         is larger than tresh, v(n) is included in the set of representers. A
%         consequence is the increase of the order of the filter.
% ker   : kernel, e.g., 'poly', 'rbf', ...
% p1    : parameter of the kernel, e.g., std of the rbf kernel
%
% output of the function
% err     : a priori output estimation error
% tdict   : time indexes of the v(i)'s inserted into the dictionary
% ndict   : size of the dictionary
% ndict_t : evolution of size of the dictionary as a function of time
%===============================================================================


function [e,tdict,ndict,ndict_t] = krls_cs(v,d,tresh,ker,p1)

%====================================================================
% Initialization
%
% dict   : dictionary
% Nbrep  : number of representers
% tdict  : time indexes of representers
%====================================================================
dic=v(1,:);
tdict = 1;
Nbrep=1;
k=kernel(ker,dic,dic,p1);
Kinv=1/k;
alpha=d(1)/k;
%alpha=0;
modict=sqrt(k);
modRep=sqrt(k);

P=1;

% Loop for filtering
for i = 2 : size(v,1)
    b = v(i,:);
    kv = kernel(ker,dic(1:Nbrep,:),b,p1);
    k = kernel(ker,b,b,p1);
    C = kv./(sqrt(k)*modict);
        
    % Computation of the novelty parameter, denoted below by delta, 
    % of the current input v(i)
    a = Kinv*kv;
    delta = k - kv' * a;
    e(i) = d(i) - kv' * alpha;
    
    % Case 1: v(i) is sufficiently novel to be included in the set of
    % representers. The order of the filter increases and its tap weights
    % are updated.
    
    if(max(abs(C)) < tresh)
        dic = [dic;b];
        tdict = [tdict; i];
        tdict = [tdict; i];
        modict = [modict; sqrt(k)];

        Kinv = [delta*Kinv+a*a', -a; -a',1]/delta;
        z = zeros(Nbrep,1);
        P = [P,z; z',1];
        alpha = [alpha-a*e(i)/delta; e(i)/delta];
        modRep = [modRep; sqrt(k)];
        Nbrep = Nbrep + 1;
    
    % Case 2: v(i) is unsufficiently novel to be included in the set of
    % represented. The order of the filter is not modified. Only the tap
    % weights are updated.
    else
        pa = P * a;
        q = pa/(1 + a'*pa);
        P = P - q * pa';
        alpha = alpha + Kinv * q * e(i);
    end

    ndict_t(i-1) = Nbrep;
    
end
ndict = length(tdict);
return;