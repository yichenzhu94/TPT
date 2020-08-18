%% Localisation avec ancres

clear all;
close all;
clc

% Paramètres 
M= 5;
T= 120;
sigma = sqrt(0.1);
P0 = 1;
d0 = 1;
eta = 2.3;

z = rand + 1i*rand; % position capteur 
zeta = rand(1,M) + 1i*rand(1,M); % position ancres


% Génération des observations
err = sigma*randn(M,T); 
dist = abs(z-zeta);
P = P0 - 10*eta*log10(dist'/d0)*ones(1,T) + err;

% Estimation des distances
Pbar = mean(P');
distHat = d0*10.^((P0 - Pbar)/(10*eta));

% Estimateur carré non biaisé
DistHat = (distHat.^2)*10.^(((-2*sigma^2)*log(10))/(((10*eta)^2)*T));

% Estimateur de la position au sens des moindre carré
for i = 2:M
    deltaHat(i-1) = DistHat(i)-DistHat(1);
    Phi(i-1) = zeta(i)-zeta(1);
    b(i-1) = real(zeta(i))^2-real(zeta(1))^2 + imag(zeta(i))^2-imag(zeta(1))^2;
end

Phi = 2*[real(Phi') imag(Phi')];
zHat = inv(Phi'*Phi)*Phi'*(b-deltaHat)';
z_est = zHat(1)-1i*zHat(2);

figure()
xlim([0 1]);
ylim([0 1]);
hold on
plot(real(z),imag(z),'x')
plot(real(z_est),imag(z_est),'o')
hold off
legend('vrai position du capteur','position estimée')

%% Algorithme du gradient

gamma = 0.01; % Pas de déscente
Nite = 3000; % Nombre d'itération
zmv = 0; % position initiale

for t=1:Nite
    d = abs(zmv-zeta);
    erreurs = ((P0-Pbar)/10/eta-log10(d/d0));
    zmv = zmv + gamma * mean(erreurs .* (zmv-zeta)./d.^2);
    E(t,:) = erreurs;
end

figure()
xlim([0 1]);
ylim([0 1]);
hold on
plot(real(z),imag(z),'x')
plot(real(zmv),imag(zmv),'o')
hold off
legend('vrai position du capteur','position estimée')

figure()
plot(E)
title('convergence des erreurs')

%% Localisation en ligne

omega = 5*10^-4;
zlms = [0.75;0];
gamma = 0.1;
correction = 10^(-2*sigma^2*log(10)/((10*eta)^2));

for n=1:5000
z(n) = 0.5 + exp(1i*omega*n)/4;
dist = abs(z(n)-zeta);
puiss = P0 - 10*eta*log10(dist'/d0) + sigma*randn(M,1); % Vecteur gaussien Mx1
D = (d0 * 10.^((P0 - puiss)/(10*eta))).^2 * correction;
Delta = [D(2)-D(1);
         D(3)-D(1);
         D(4)-D(1);
         D(5)-D(1)]; % Estimée non biaisée de delta
zlms = zlms + gamma * Phi.' * (b'-Delta - Phi*zlms);
Zlms(:,n) = zlms;
end
Zlms(2,:) = -Zlms(2,:);

figure()
% xlim([0 1]);
% ylim([0 1]);
hold on
plot(real(z),imag(z))
plot(Zlms(1,:),Zlms(2,:))
hold off

%% Localisation sans ancres
close all
clear all
clc

N = 8;
T= 100;
sigma = sqrt(0.1);
P0 = 1;
d0 = 1;
eta = 2.3;

z = rand(1,N) + 1i*rand(1,N);
% plot(z)
% axis([0 1 0 1])
figure()
hold on
for m = 1:N
   plot(real(z(m)),imag(z(m)),'o');
end
hold off
title('position des capteurs');

for i = 1:N
    for j = 1:N
        D(i,j) = abs(z(j)-z(i));
    end
end

P = eye(N) - ones(N,1)*ones(1,N)/N;
M = (-1/2)*P*D*P;
[vec_prop,val_prop] = eig(M);

figure()
hold on
for n = 1:N
   % plot(real(z(n)),imag(z(n)),'o');
   plot(sqrt(val_prop(1,1))*vec_prop(n,1),sqrt(val_prop(2,2))*vec_prop(n,2),'x');
end
hold off
title('(sqrt(lambda1)v1,sqrt(lambda2)v2');

err = sigma.*randn(N,N,T);
for i = 1:T
    Pu(:,:,i) = P0 - 10*eta*log10(D/d0) + err(:,:,i);
end

% Estimateur à partir de la formule
Pbar = mean(Pu,3);
DHat = d0*10.^((P0 - Pbar)/(10*eta));

% Estimateur non biaisé
Dhat = (DHat.^2)*10.^(((-2*sigma^2)*log(10))/(((10*eta)^2)*T));

% 
MHat = (-1/2)*P*DHat*P;
[vec_prop_h,val_prop_h] = eig(MHat);

figure()
hold on
for n = 1:N
   plot(real(z(n)),imag(z(n)),'x');
   plot(sqrt(val_prop_h(1,1))*vec_prop_h(n,1),sqrt(val_prop_h(2,2))*vec_prop_h(n,2),'o');
end
hold off
legend('vraies positions des capteurs','positions estimées')

%% Algorithme d'Oja

% Initialisation des paramètres
Omega = (10^-3)*rand(1,N);
Cst = rand(1,N);
gamma = 0.05;
sigma = 0.05;
correction = 10^(-2*sigma^2*log(10)/((10*eta)^2));
M_hat = ones(8,8);

for n = 1:5000
    z(n,:) = Cst + exp(1i*Omega*n)/4;
    for i = 1:N
        for j = 1:N
            D(i,j) = abs(z(n,j)-z(n,i));
        end
    end
    puiss = P0 - 10*eta*log10(D/d0) + sigma.*randn(N,N);
    D_hat = (d0 * 10.^((P0 - puiss)/(10*eta))).^2 * correction;
    [vec_prop,val_prop] = eig(M_hat); % On retire les vecteurs propre de M_hat à l'instant n-1
    X = [vec_prop(:,1) vec_prop(:,2)]; % X est celui de l'instant n-1
    Lambda1_hat = X(:,1)'*M_hat*X(:,1)./X(:,1)'*X(:,1); % On estime les valeurs propres
    Lambda2_hat = X(:,2)'*M_hat*X(:,2)./X(:,2)'*X(:,2);
    M_hat = (-1/2)*P*D_hat*P;  % Mise à jour de M_hat 
    X = X + (gamma/(1+trace(X*X')))*(M_hat*X - X*(X'*M_hat*X)); % l'algo d'Oja 
    Z_hat(n,:) = sqrt(Lambda1_hat)*X(:,1) + 1i*sqrt(Lambda2_hat)*X(:,2); % Les positions estimées
end

figure()
hold on
for n = 1:5000
    plot(real(z(n,:)),imag(z(n,:)),'x');
end
hold off

figure()
subplot(211)
plot(real(z(5000,:)),imag(z(5000,:)),'x');
subplot(212)
plot(real(Z_hat(5000,:)),imag(Z_hat(5000,:)),'o');

