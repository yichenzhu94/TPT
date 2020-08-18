function [time,cost,PSNR]=compensation3(k,brow,bcol,search,distance,lambda)
%%
tic;
filename='test_cif.y';
cur=getCifYframe(filename,k);
ref=getCifYframe(filename,k+distance);
%image(cur);
%colormap(gray(256));
%axis image;
%axis off;
%%
mvf=meReg(cur,ref,brow,bcol,search,lambda);
%displayMVF(cur,mvf,8);
%%
motcomp=mc(ref,mvf);
%image(motcomp);
%colormap(gray(256));
%%
cost=codingCost(mvf,[brow bcol]);
%%
M=size(cur);
PSNR=10*log10((255^2*M(1)*M(2))./sum(sum((cur-motcomp).^2)));
%%
time=toc;
end