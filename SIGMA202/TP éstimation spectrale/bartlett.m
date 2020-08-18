% Bartlett
function periodoBartlett=bartlett(X,L)

n = fix(length(X)/L);
periodoB = zeros(L,n);
for i = 1:L
    periodoB(i,:) = (abs((fft(X(10*(i-1)+1:10*(i-1)+n)))).^2)/n;
end
periodoBartlett = mean(periodoB);

end