function x = MdctOp( s , sizes )
% MDCTOP MDCT Operator

x = zeros(length(s) * length(sizes),1);
L = length(s);

for i=1:length(sizes)
    x(((i-1)*L)+1:i*L) = (1/sqrt(length(sizes)))*mdct(s , sizes(i));
end

end
