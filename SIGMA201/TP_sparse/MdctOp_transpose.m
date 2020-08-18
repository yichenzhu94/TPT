function s = MdctOp_transpose(x , sizes)
% MDCTOP_TRANSPOSE MDCT Operator Transposed

L = length(x)/length(sizes);
s = zeros(L,1);

for i=1:length(sizes)
    s = s + imdct(x(((i-1)*L)+1:i*L) , sizes(i));
end

end

