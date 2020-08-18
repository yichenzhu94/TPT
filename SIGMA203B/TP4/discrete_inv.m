function Inv = discrete_inv(x, v, p)
%%% Inverse distribution function of a discrete distribution with values v
%%% and weights p. 
% x: a vector with entries between 0 and 1 
% v: the values of the discrete distribution 
% p: a vector of same size as v: the weights of the probability distribution
% RETURN: a vector of same size as x: the evaluations of the inverse cdf 
% at x. 
  [v, idx] = sort (v);
  p = cumsum(p(idx)) / sum (p);  % Reshape and normalize probability vector
  
  if(any(x > 1) || any(x<0) ) 
      error('x entries should be between 0 and 1')
  end
  Inv = zeros(1, length(x));
  for i = 1:length(x)
    idsGreat = [p >= x(i)] ; 
    Inv(i) = min(v(idsGreat)) ;
  end
end
