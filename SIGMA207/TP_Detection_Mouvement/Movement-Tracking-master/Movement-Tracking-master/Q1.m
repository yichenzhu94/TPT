clear all;
%%
%1.1
filename='test_cif.y';
k=10;
frame=getCifYframe(filename,k);
image(frame);
colormap(gray(256));
axis image;
axis off;
%%
%1.2
K=234;
figure(2);
for k=1:K
    frame=getCifYframe(filename,k);
    image(frame);
    colormap(gray(256));
    axis image;
    axis off;
    pause(1/30);
end
%%
%1.3
%cur Image monochrome courante. 
%ref Image monochrome de référence. 
%brow,bcol Taille du bloc pour l’estimation de mouvement. Utilisez des tailles entre 4 et 16. 
%search Rayon de la fenêtre de recherche. Utilisez des valeurs entre 8 et 30.
cur=getCifYframe(filename,3);
ref=getCifYframe(filename,4);
brow=4;
bcol=4;
search=8;
mvf=me(cur,ref,brow,bcol,search);
displayMVF(cur,mvf,8);
%%
%1.4
brow=4;
bcol=4;
search=8;
distance=1;
%%
clear time cost PSNR;
for i=1:16
    %brow=i;
    %bcol=i; %from 4 to 16
    %search=i; %from 8 to 30
    distance=i;%from 1 to 16
    [time(i),cost(i),PSNR(i)]=compensation(3,brow,bcol,search,distance);
end
%%
figure();
plot(time,'--o');
xlabel('time distance');
ylabel('run time');
grid on;
figure();
plot(cost,'--o');
xlabel('time distance');
ylabel('coding cost');
grid on;
figure();
plot(PSNR,'--o');
xlabel('time distance');
ylabel('PSNR');
grid on;
