function X  = discrete_rnd(N, v, p)
% N: number of desired samples. 
% v: the values of the discrete distribution 
% p: a vector of same size as v: the weights of the probability distribution
% RETURNS: a vector of size N : id sample from the discrete distribution
% with values v and weights p
U = rand(1,N);
X = discrete_inv(U,v,p) ;
end

