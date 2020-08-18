function h = pmfEntr(pmf)
%PMFENTR compute the entropy associated to a discrete mass prob function
%   h = pmfEntr(pmf);
%   pmf should be a 1-D probability vector (row or column), and it CAN
%   contain zero values.
if size(pmf,2) >1,
    pmf = pmf';
end
% if sum(pmf)>1,
%     warning('Invalid PMF in input');
% end
p = pmf(pmf>0);
h = p'*log2(1./p);
end