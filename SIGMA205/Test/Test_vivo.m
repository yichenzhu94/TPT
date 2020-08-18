clear all
close all
clc

[x,Fs]=audioread('Test.wav');

[DifTest dur_relTest]= indexation(x, Fs);

load('Workspace_all.mat')

load('Datos.mat')

L= [length(DifBG1);
    length(DifBG2);
    length(DifBG3);
    length(DifBG4);
    length(DifBG5);
    length(DifBG7);
    length(DifFJ1);
    length(DifFJ2);
    length(DifFJ3);   
    length(DifFJ4);
    length(DifFJ5);
    length(DifFJ6);
    length(DifFJ7);
    length(DifHB1);
    length(DifHB2);
    length(DifHB3);
    length(DifHB4);
    length(DifHB5);
    length(DifHB6);
    length(DifHB7);
    length(DifHB8);
    length(DifILRR1);
    length(DifILRR2);
    length(DifILRR3);
    length(DifILRR4);
    length(DifILRR5);
    length(DifILRR6);
    length(DifILRR7);
    length(DifILRR8);
    length(DifJB1);
    length(DifJB2);
    length(DifJB3);
    length(DifJB4);
    length(DifJB6);
    length(DifJB7);
    length(DifLTWYL1);
    length(DifLTWYL2);
    length(DifLTWYL3);
    length(DifLTWYL4);
    length(DifLTWYL5);
    length(DifLTWYL6);
    length(DifLTWYL7);
    length(DifOM1);
    length(DifOM2);
    length(DifOM3);
    length(DifOM4);
    length(DifOM5);
    length(DifOM6);
    length(DifOM7);
    length(DifOM8);
    length(DifSYA1);
    length(DifSYA2);
    length(DifSYA3);
    length(DifSYA4);
    length(DifSYA5);
    length(DifSYA6);
    length(DifT1);
    length(DifT2);
    length(DifT3);
    length(DifT4);
    length(DifT5);
    length(DifT6);
    length(DifT7);
    length(DifT8);
    length(DifW1);
    length(DifW2);
    length(DifW3);
    length(DifW4);
    length(DifW5);
    length(DifW6);
    length(DifWOTB1);
    length(DifWOTB2);
    length(DifWOTB3);
    length(DifWOTB4);
    length(DifYS1);
    length(DifYS2);
    length(DifYS3);
    length(DifYS4);
    length(DifYS5);
    length(DifYS6);
    length(DifYS7);
    length(DifYS8)];

M= [L Dif];
N= [L dur_rel];
[a b]= size(M);

for i=1:a
    
        
           long= min(M(i,1), length(DifTest));
           score(i)= ((1*sum(M(i,2:long+1)==DifTest(1:long))+ 1*sum(N(i,2:long+1)==dur_relTest(1:long))))/long;
           
end
 
[value position]= max(score);


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




    



    



