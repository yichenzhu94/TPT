function [qx,qy]=idxsb(k,n,j)
k=k-1;
j0=n/2^j;
s=j0*2^(ceil(k/3)-1);
if k==0
    sx=0;
    sy=0;
    s=j0;
else
    if mod(k,3)==0
        sx=s;
        sy=s;
    elseif mod(k,3)==1
        sx=s;
        sy=0;
    else
        sx=0;
        sy=s;
    end;
end;
qx=(sx+1:sx+s);
qy=(sy+1:sy+s);