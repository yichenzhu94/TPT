function [Dif relative_duration]= indexation(y, Fs)

% Detection d'attaque
y= y(:,1);

seuil= 0.15*max(y);

for i=1:length(y)
    if abs(y(i)) < seuil
        y_new(i)= 0;
    else
        y_new(i)= y(i);
    end
end


N=2000;
k=1;
for i=N+1:length(y)
    aux= y_new(i-N:i)==zeros(size(y_new(i-N:i)));
    if  sum(aux)== N && y_new(i)~=0
        
        position(k)=i;
        k= k+1;
        
    end
        
end


% figure()
% plot(y,'k')
% mini= min(y); maxi= max(y);
% for j=1:length(position)
%     line([position(j) position(j)], [mini maxi])
% end

freq=zeros(size(position));
duration= zeros(size(position));
err=0;
for i=1:length(position)-1
    
    note1= y(position(i):position(i+1));
%     [theta e y_est]= RLS(note1, 0.999, 60, 0.001);
%     freq(i)= fondamentale(e, 44100, 0);
    freq2(i)=fondamentale(note1,44100,0);
    duration(i)= length(note1)*Fs^-1;
    
%    err= [err e];
end

% [theta e y_est]= RLS(y(position(end):length(y)), 0.999, 60, 0.001);
% err= [err e];
% freq(end)= fondamentale(e, 44100,0);
freq2(end)= fondamentale(y(position(end):length(y))', 44100,0);
duration(end)= length(y(position(end):length(y)))*Fs^-1;

Ffund= [32.7032 34.6479 36.7081 38.8909 41.2035 43.6536 46.2493 48.9995 51.9130 55 58.2705 61.7354];
%Tableau contenant toutes les fréquences
for j=1:7
Freq(:,j)= 2^(j-1)*Ffund;
end

freq=freq2;
for j=1:length(freq)
    
    dif= abs(Freq-freq(j));
    [a, b]= find(dif == min(dif(:)));
    ind(j)=a;
    
end


for j=2:length(ind)
    if ind(j-1)==ind(j)
       Dif(j)=0;
    elseif freq(j)>freq(j-1)
       Dif(j)=1;
    else
       Dif(j)=2;
    end
end


for j=1:length(duration)-1
    dur_rel(j)=duration(j+1)/duration(j);
end

relative_duration= round(dur_rel);