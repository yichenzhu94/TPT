clear all
close all
clc

% n=82;
load('CR.mat');
load('CR2.mat');
CR2= CR2(:,2:end);
% CR2(n,:)=zeros(size(CR2(1,:)));
% CR(n,:)=zeros(size(CR(1,:)));
load('MN.mat');
% M(n,2:end)=zeros(size(M(1,2:end)));
Fs = 44100;
r = audiorecorder(Fs,16,1);
fprintf('Press any key to start recording...\n');
pause;
fprintf('Recording...\n');
record(r)
fprintf('Press any key to finish recording...\n');
pause;
stop(r)
% fprintf('Press any key to save the recording...\n');
% pause;
y = getaudiodata(r, 'double');
%[x,Fs]=audioread('Wheels_on_the_bus.wav');

[Dif_req CR2_req CR_req]= indexation2(y, Fs);
CR2_req=CR2_req(:,2:end);

K= length(CR_req);
[m n]= size(M);

N=10;
A_Dif= vecteurs(Dif_req,N);
A_CR= vecteurs(CR_req, N);
A_CR2= vecteurs(CR2_req,N);
[p q]= size(A_Dif);

for i=1:m
    
    Dif=M(:,2:end);
    L=M(i,1);
    Dif_chanson= Dif(i,1:L);
    CR_chanson= CR(i,1:L);
    CR2_chanson= CR2(i,1:L);
    B_Dif= vecteurs(Dif_chanson, N);
    B_CR= vecteurs(CR_chanson, N);
    B_CR2= vecteurs(CR2_chanson, N);
    [r s]= size(B_Dif);
    
    for j=1:p
        
        P= [A_CR(j,:) A_Dif(j,:)];
        for k=1:r
        poids= norm(A_CR2(j,:)-B_CR2(k,:));
        Q= [B_CR(k,:) B_Dif(k,:)];
        distance(j,k)= (norm(P-Q)*poids);
        end
        
        dist_aux(j)= min(distance(:));
    end
    
    dist(i)= sum(dist_aux);
    
    
end

sorteo = sort(dist);
position1= find(dist==sorteo(1));
position1= position1(1);
position2= find(dist== sorteo(2));
position2= position2(1);
position3= find(dist== sorteo(3));
position3= position3(1);

if position1~=52 && position1~=32
   position= position1;
elseif position2~=52 && position2~=32
   position= position2;
else
    position=position3;
end

if sum(position==1:6)~=0
   disp('Vous avez chantonné Barbie Girl')
elseif sum(position==7:13)~=0
   disp('Vous avez chantonné Frère Jacks')
elseif sum(position==14:21)~=0
   disp('Vous avez chantonné Happy Birthday')
elseif sum(position==22:29)~=0
   disp('Vous avez chantonné I love Rock and Roll')
elseif sum(position==30:35)~=0
   disp('Vous avez chantonné Jingle Bells')
elseif sum(position==36:42)
   disp('Vous avez chantonné Love the way you Lie')
elseif sum(position==43:50)
   disp('Vous avez chantonné Old McDonald')
elseif sum(position==51:56)
   disp('Vous avez chantonné See you again')
elseif sum(position==57:64)
   disp('Vous avez chantonné Thriller')
elseif sum(position==65:70)
    disp('Vous avez chantonné Wonderwall')
elseif sum(position==71:74)
    disp('Vous avez chantonné the wheels on the bus')
elseif sum(position==75:82)
    disp('Vous avez chantonné Yellow submarine')
end

