function [tout]=spectrogramme(u,Fe)
% Tous les nb �chantillons nous extrayons une fen�tre de taille N dont nous
% calculons la TFD d'ordre M (apres fenetrage par hamming). Le resultat est
% affiche dans les colonne. L'affichage a besoin de la frequence
% d'echantillonnage Fe.

if nargin ~= 2
  error('Entrez un signal et sa fréquence d''échantillonnage !');
end;


fenspe=0.05;  % fenetre pour le spectrogramme 

NPK=size(u,1);
if(NPK<4)
    NPK=size(u,2);
    if(NPK<4)
        echo('Probleme probable de donnees')
        return
    end
end

duree = double(NPK)/double(Fe);



NZ=int32(Fe*fenspe);  %cela correspond à 0.05 s






nb=uint32(NZ/2)  % ICI ADAPTATION GROUPE 6 et blindage divers....
N=2*nb

t=0:N-1;
dt=double(t);
DN=double(N)
w=0.54-0.46*cos(2*pi*dt/(DN-1));

M=N; 

zz=(length(u)-N)/nb;

%tout=zeros(M,zz);

for n=1:nb:length(u)-N
    mu=u(n+1:n+N);% morceau de u � traiter (w non nul)
    mu=mu(:)'; %s'assurer que l'on a une ligne
    x=mu.*w; %signal dont il faut prendre la TFD d'ordre M
    tmp=abs(fft(x));
    tout(1:1:M/2+1,floor((n-1)/nb)+1)=tmp(M/2+1:-1:1);
end

%SSX='Axe des temps';   ne marche pas 
%xlabel(SSX);
imagesc(log(tout));

%x=linspace(0,10,1000); % 0 to 10 s, 1000 samples
%y=logspace(1,3,1000); % 10^1 to 10^3, 1000 samples
%set(gca,'Yscale','normal','Ydir','normal','YTick', [10 100 1000]);

xlabel( 'Durée en secondes')

ylabel( 'Fréquence en Hertz')

ntout=size(tout,1)
set(gca,'YTick', [1 ntout/2 ntout],'YTickLabel', { num2str(Fe/2) num2str(Fe/4) num2str(0) } );

ntout=size(tout,2)
set(gca,'XTick', [1 ntout/2 ntout],'XTickLabel', { num2str(0) num2str(duree/2.) num2str(duree) } );
