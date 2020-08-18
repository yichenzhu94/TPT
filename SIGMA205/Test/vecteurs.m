function A=vecteurs(v, N)

L=length(v);
for i=1:L-N
    
    A(i,:)=v(i:i+N);
    
end
