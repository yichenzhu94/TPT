%%
%2.1
brow=4;
bcol=4;
search=8;
distance=1;
%%
clear time cost PSNR;
for i=8:30
    %brow=i;
    %bcol=i; %from 4 to 16
    search=i; %from 8 to 30
    %distance=i;%from 1 to 16
    [time(i),cost(i),PSNR(i)]=compensation(3,brow,bcol,search,distance);
    [time2(i),cost2(i),PSNR2(i)]=compensation2(3,brow,bcol,search,distance);
end
%%
figure();
plot(time,'--o');
hold on;
plot(time2,'--s','Color','r');
ylabel('run time');
grid on;
figure();
plot(cost,'--o');
hold on;
plot(cost2,'--s','Color','r');
ylabel('coding cost');
grid on;
figure();
plot(PSNR,'--o');
hold on;
plot(PSNR2,'--s','Color','r');
ylabel('PSNR');
grid on;
%%
%2.2
cur=getCifYframe(filename,3);
ref=getCifYframe(filename,4);
brow=4;
bcol=4;
search=8;
distance=1;
lambda=0.1;
mvf=meReg(cur,ref,brow,bcol,search,lambda);
displayMVF(cur,mvf,8);
%%
[time1,cost1,PSNR1]=compensation(3,brow,bcol,search,distance);
[time2,cost2,PSNR2]=compensation2(3,brow,bcol,search,distance);
k=0;
for i=0:0.05:0.3
    k=k+1;
    lambda=i;
    [time3(k),cost3(k),PSNR3(k)]=compensation3(3,brow,bcol,search,distance,lambda);
end
PSNR1=PSNR1*ones(1,length(PSNR3));
PSNR2=PSNR2*ones(1,length(PSNR3));
%%
figure();
plot(0:0.05:0.3,PSNR1,'--o','Color','b');
hold on;
plot(0:0.05:0.3,PSNR2,'--s','Color','r');
plot(0:0.05:0.3,PSNR3,'--*','Color','g')
ylabel('PSNR');
grid on;
%%
%2.4
filename='color_cif.yuv';
cur=getCifYUVframe(filename,3);
ref=getCifYUVframe(filename,4);
brow=4;
bcol=4;
search=8;
distance=1;
lambda=0.1;
mvf=meColor(cur,ref,brow,bcol,search);
curRGB=colorTransform(cur);
image(curRGB);
displayMVF(curRGB,mvf,8);