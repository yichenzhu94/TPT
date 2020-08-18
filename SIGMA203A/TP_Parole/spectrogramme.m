function spectrogramme(x, N, M, Fe, Fc)

Nbre_ech = length(x);
w = 0.54 - 0.46*cos(2*pi*(0:N-1)'/N);
Nbre_fen = floor((Nbre_ech-N)/M) + 1;
kc = round(N*Fc/Fe);
Xtilde = zeros(kc, Nbre_fen) ; 
for no_fen = 1:Nbre_fen               
    n1 = (no_fen-1)*M + 1; 
    n2 = n1 + N - 1;    
    X = fft(x(n1:n2).*w);     
    Xtilde(:, no_fen) = X(1:kc);
end
Eps = 1E-6;
Xtilde_db = 20*log10(abs(Xtilde+Eps));

val_max = max(max(Xtilde_db));
val_min = val_max - 80;
Xtilde_db = max(Xtilde_db, val_min*ones(size(Xtilde_db)));
%Xtilde_db(:,130) = val_max*ones(L/2+1,1);
temps = (0:Nbre_fen-1)*M/Fe;
freq = (0:kc-1)*Fe/N/1000;  

imagesc(temps, freq, Xtilde_db)
axis xy
xlabel('Temps [s]')
ylabel('Fréquences [kHz]')
drawnow