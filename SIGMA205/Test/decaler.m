function m = decaler(x, y);



Lx=length(x);
Ly=length(y);

decalage=zeros(1,Lx);

i=1;


if y(end)==0;
    i=Ly;
   while y(end)==0
       y = y(1:i-1);
       i= i-1;
   end
end


while decalage(end)~=y(end)
    
   decalage=zeros(1,Lx);
   decalage(i:i+length(y)-1)= y;
   D(i,:)=decalage;
   i=i+1;
end

[m n]= size(D);


