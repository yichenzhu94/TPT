clear all; 
close all; 
clc

load('Workspace_all.mat')
% A=zeros(84,53);
% A(1,:)=[ DifBG1(1,:) zeros(1,53-length(DifBG1))];
% A(2,:)=[ DifBG2(1,:) zeros(1,53-length(DifBG2))];
% A(3,:)=[ DifBG3(1,:) zeros(1,53-length(DifBG3))];
% A(4,:)=[ DifBG4(1,:) zeros(1,53-length(DifBG4))];
% A(5,:)=[ DifBG5(1,:) zeros(1,53-length(DifBG5))];
% A(6,:)=[ DifBG6(1,:) zeros(1,53-length(DifBG6))];
% A(7,:)=[ DifBG7(1,:) zeros(1,53-length(DifBG7))];
% A(8,:)=[ DifFJ1(1,:) zeros(1,53-length(DifFJ1))];
% A(9,:)=[ DifFJ2(1,:) zeros(1,53-length(DifFJ2))];
% A(10,:)=[ DifFJ3(1,:) zeros(1,53-length(DifFJ3))];
% A(11,:)=[ DifFJ4(1,:) zeros(1,53-length(DifFJ4))];
% A(12,:)=[ DifFJ5(1,:) zeros(1,53-length(DifFJ5))];
% A(13,:)=[ DifFJ6(1,:) zeros(1,53-length(DifFJ6))];
% A(14,:)=[ DifFJ7(1,:) zeros(1,53-length(DifFJ7))];
% A(15,:)=[ DifHB1(1,:) zeros(1,53-length(DifHB1))];

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
    for j=1:a
        
        if i~=j 
           long= min(M(i,1), M(j,1));
           score(i,j)= ((1*sum(M(i,2:long+1)==M(j,2:long+1))+ 1*sum(N(i,2:long+1)==N(j,2:long+1))))/long;
        else
           score(i,j)=0;
        end
    end
end

[n m]= size(score);

for i=1:n
    [value position(i)]= max(score(i,:));
end

reussite=zeros(1,82);


for i=1:6
    
    v= position(1:6);
    aux = v(i)==1:6;
    aux(i)=0;

    if sum(aux)~=0
       reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
     clear aux
end
  
for i=7:13
    
    v= position(1:13);
    aux =(v(i)==(7:13));
    aux(i)=0;

    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end

   clear aux  
end


for i=14:21
    
    v=position(1:21);
    aux = (v(i)==(14:21));
    aux(i)=0;

    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
   
    clear aux

end
   
 
for i=22:29
    
    v= position(1:29);
    aux = v(i)==(22:29);
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
    clear aux

end
   
 
for i=30:35
    
    v=position(1:35);
    aux = (v(i)==(30:35));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
    clear aux

end

 
for i=36:42
    
    v=position(1:42);
    aux = (v(i)==(36:42));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
    clear aux

end

 
for i=43:50
    
    v= position(1:50);
    aux = (v(i)==(43:50));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
    clear aux

end
   
 clear aux
 
for i=51:56
    
    v= position(1:56);
    aux = (v(i)==(51:56));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
    clear aux

end
    
 
for i=57:64
    
    v= position(1:64);
    aux = (v(i)==(57:64));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
     clear aux

end

 
for i=65:70
    
    v= position(1:70);
    aux = (v(i)==(65:70));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
     clear aux

end

 
for i=71:74
    v= position(1:74);
    aux = (v(i)==(71:74));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
     clear aux

end


for i=75:82
    v= position(1:82);
    aux = (v(i)==(75:82));
    aux(i)=0;
    if sum(aux)~=0
        reussite(i)= 1;
    else
        reussite(i)=0;
    end
    
     clear aux

end


taux_reussite = sum(reussite)/length(reussite)


