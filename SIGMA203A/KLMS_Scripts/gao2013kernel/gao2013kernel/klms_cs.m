%===============================================================================
% The Kernel Least Mean Square based on Coherence Sparsification (KLMS-CS) Algorithm
% contact: cedric.richard@unice.fr
%
% W. Gao, J. Chen, C. Richard, J. Huang and R. Flamary, "Kernel LMS with 
% forward-backward splitting for dicitonary learning", in Proc. IEEE ICASSP, May. 2013.
%
%
% function [err,tdict,ndict,ndict_t]=klms_cs(v,d,eta,tresh,ker,xi);
%
% inputs of the function
% v     : matrix of the inputs of the filter, each row corresponding
%         to the input values at a given time instant.
% d     : row vector of desired outputs.
% eta   : step-size of KLMS
% tresh : novelty threshold in [0,1]. If the novelty coefficient (coherence)
%         of an input v(i) is larger than tresh, it is inserted into the
%         dictionary. A consequence is the increase of the order of the filter.        
% ker   : kernel, e.g., 'poly', 'rbf', ...
% xi    : parameter of the kernel, e.g., std of the rbf kernel
%
% output of the function
% err     : a priori output estimation error
% tdict   : time indexes of the v(i)'s inserted into the dictionary
% ndict   : size of the dictionary
% ndict_t : evolution of size of the dictionary as a function of time
%===============================================================================


function [err,tdict,ndict,ndict_t] = klms_cs(v,d,eta,tresh,ker,xi)

%====================================================================
% Initialization
%
% dict   : dictionary
% tdict  : time indexes of the elements v(i) of the dictionary
% modict : modulus of the elements v(i) of the dictionary
%====================================================================
dic = v(1,:);
tdict = 1;
k = kernel(ker,dic,dic,xi);
modict = sqrt(k);


% Initialization of the weigth vector
alpha = d(1)/k;

% Filtering process
i = 1;
while i < size(v,1)
    i = i + 1;
    
    % Mapping of input v(i) into the feature space
    b = v(i,:);
    kv = kernel(ker,dic,b,xi);
    k = kernel(ker,b,b,xi);
    C = kv./(sqrt(k)*modict);
    
    % If v(i) is sufficiently novel, that is, the coherence of 
    % the dictionary remains smaller than the threshold tresh, v(i)
    % is inserted into the dictionary and the size of the weight
    % vector alpha is increased by 1.
    if (max(abs(C)) < tresh)  
        dic = [dic; b];
        modict = [modict; sqrt(k)];
        tdict = [tdict; i];
        alpha = [alpha; 0];
    end
    
    % Iteration of APA in the feature space
    H = kernel(ker,dic,v(i:-1:max([i 1]),:),xi)';
    D = d(i:-1:max([i 1]))';
    E = D - H * alpha;
    err(i) = E(1);
    alpha = alpha + eta * H' * E;
    
    ndict_t(i-1) = size(dic,1);
end

ndict = length(tdict);
return;