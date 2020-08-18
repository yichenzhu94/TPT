                  clear all
close all
clc

load('All_Here.mat');
% [y,Fs]=audioread('Test.wav');
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
% audiowrite('test.wav', y, Fs);
[DifTest dur_relTest] = indexation(y,Fs);
% Tempo = tempo2(y,Fs);
% if Tempo(3) > 0.5
%     Tempo = Tempo(1);
% else
%     Tempo = Tempo(2);
% end
% 
% barriere = 120;
% if Tempo < barriere
%     load('Low_tempo.mat');
%         for i=1:Low
%         m = decaler(Dif_low(i,:),DifTest);
%         Dif_aux = Dif_low(i,:);
%         dur_relaux = dur_rel_low(i,:);
%         L = length(DifTest);
%     
%             for j=1:m-2
%                 
%             aux(j)= (sum(Dif_aux(j:j+L-1)==DifTest)+sum(dur_relaux(j:j+L-1)==dur_relTest))/L;
%             P = [DifTest dur_relTest];
%             Q = [Dif_aux(j:j+L-1) dur_relaux(j:j+L-1)];
%             emd(j) = norm(P-Q);
%             end
%     
%         n_aux= max(aux);
%         emd_opt = min(emd);
%         score_brut(i)= n_aux;
%         score_emd(i)= emd_opt;
%         end
%         
%         [val, pos] = max(score_brut);
%         [value, position]= min(score_emd);
%        
%         if sum(position==1:7)+sum(pos==1:7)~=0
%             disp('Vous avez chantonné Frère Jacks')
%         elseif sum(position==8:15)+sum(pos==8:15)~=0
%             disp('Vous avez chantonné Happy Birthday')
%         elseif sum(position==16:21)+sum(pos==16:21)~=0
%             disp('Vous avez chantonné Jingle Bells')
%         elseif sum(position==22:28)+sum(pos==22:28)~=0
%             disp('Vous avez chantonné Love the way you Lie')
%         elseif sum(position==29:36)+sum(pos==29:36)~=0
%             disp('Vous avez chantonné Old McDonald')
%         elseif sum(position==37:42)+sum(pos==37:42)~=0
%             disp('Vous avez chantonné See you again')
%         elseif sum(position==43:50)+sum(pos==43:50)~=0
%             disp('Vous avez chantonné Thriller')
%         elseif sum(position==51:56)+sum(pos==51:56)~=0
%             disp('Vous avez chantonné Wonderwall')
%         elseif sum(position==57:64)+sum(pos==57:64)~=0
%         disp('Vous avez chantonné Yellow submarine')
%         end
% else
%     load('High_tempo.mat');
%         for i=1:High
%         m = decaler(Dif_high(i,:),DifTest);
%         Dif_aux = Dif_high(i,:);
%         dur_relaux = dur_rel_high(i,:);
%         L = length(DifTest);
%     
%             for j=1:m-2
%                 
%             aux(j)= (sum(Dif_aux(j:j+L-1)==DifTest)+sum(dur_relaux(j:j+L-1)==dur_relTest))/L;
%             P = [DifTest dur_relTest];
%             Q = [Dif_aux(j:j+L-1) dur_relaux(j:j+L-1)];
%             emd(j) = norm(P-Q);
%             end
%     
%         n_aux= max(aux);
%         emd_opt = min(emd);
%         score_brut(i)= n_aux;
%         score_emd(i)= emd_opt;
%         end
%         
%         [val, pos] = max(score_brut);
%         [value, position]= min(score_emd);
%         if sum(position==1:7)+sum(pos==1:7)~=0
%             disp('Vous avez chantonné Barbie Girl')
%         elseif sum(position==8:15)+sum(pos==8:15)~=0
%             disp('Vous avez chantonné Happy Birthday')
%         elseif sum(position==16:23)+sum(pos==16:23)~=0
%             disp('Vous avez chantonné I love Rock N Roll')
%         elseif sum(position==24:29)+sum(pos==24:29)~=0
%             disp('Vous avez chantonné Jingle Bells')
%         elseif sum(position==30:37)+sum(pos==30:37)~=0
%             disp('Vous avez chantonné Old McDonald')
%         elseif sum(position==38:45)+sum(pos==38:45)~=0
%             disp('Vous avez chantonné Thriller')
%         elseif sum(position==46:53)+sum(pos==46:53)~=0
%         disp('Vous avez chantonné Yellow submarine')
%         end
% end


[a b]=size(Dif);

for k = 1:a
    m = decaler(Dif(k,:),DifTest);
    Dif_aux = Dif(k,:);
    dur_relaux = dur_rel(k,:);
    L = length(DifTest);
    
         for j=1:m-2
                
          aux(j)= (sum(Dif_aux(j:j+L-1)==DifTest)+sum(dur_relaux(j:j+L-1)==dur_relTest))/L;
%           P = [DifTest' dur_relTest'];
%           Q = [Dif_aux(j:j+L-1)' dur_relaux(j:j+L-1)'];
%           emd(j) = norm(P-Q);
         end
    
      n_aux= max(aux);
%      emd_opt = min(emd);
      score(k)= n_aux;
%     score(k)= emd_opt;

%     init_dur = 2;
%     P = [DifTest' dur_relTest'];
%     Q = [Dif_aux' dur_relaux'];
%     m = length(DifTest);
%     n = length(Dif_aux);
%     EMD = zeros(m,n);
%     for i = 1:m
%         Poid_P = init_dur*prod(dur_relTest(1:i));    
%         for j = 1:n
%             Poid_Q = init_dur*prod(dur_relaux(1:j));
%             dij = norm(P(i,:)-Q(j,:));
%             fij = abs(Poid_P-Poid_Q);
%             EMD(i,j) = dij*fij;
%         end
%     emd(i) = min(EMD(i,:));
   
% %    [value position] = min(EMD(:));
% %    [r c] = ind2sub(size(EMD),position);
%     end
%      EMD_all(k) = sum(emd);
end

[value position]= max(score);
% [v p] = sort(score);


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
