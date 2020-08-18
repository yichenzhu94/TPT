function bits = codingCost(mvf,bsize)
%CODINGCOST computes the coding cost of a motion vector field
%   bits = codingCost(mvf,bsize)
%   bsize is the input blocksize of the dense mvf
%   the output variable is the number of bit needed to code the MVF
%

X = mvf(1:bsize(1):end,1:bsize(2):end,1);
X=X(:);
Y = mvf(1:bsize(1):end,1:bsize(2):end,2);
Y=Y(:);

bits = ceil((entr(X)+entr(Y))*numel(X));
end

function h = entr(X)
occ = hist(X,min(X):max(X));
n=occ(find(occ));
p = n'/sum(n);
h = -p'*log2(p);
end


