clear all
close all
clc

%% Data generation

% Initialisation of general parameters

Fs = 8000; % Sampling frequency
M = 7; % Number of the pitch
gamma = 0.001; % sound energy parameter
R = 10^-8; % Variance observation
S = 5*eye(2); % Variance evolution when rt != rt-1 
Q = 0.001*eye(2); % Variance evolution when rt = rt-1 
T = 80000; % Signal size
nu = 0.002; % Parameter of transition matrix
Z = (nu/(M-1))*ones(M); 
for i = 1:M
    Z(i,i) = 1-nu;
end % Z The transition matrix

omega = 0.2*2.^([1 3 4 6 8 9 11]/12); %0.2*2.^([1 7 12]/12);
% Test a musical scale below
% 0.2*2.^([1 3 5]/12); % C Major 
% 0.2*2.^([1 3 5 6 8 10 12]/12); % Major Scale
% 0.2*2.^([1 3 4 6 8 9 11]/12); % Minor Scale
% 0.2*2.^([1 2 5 6 8 9 11]/12); % Hizac
X = zeros(T,2); 
Y = zeros(T,1);
B = sqrt(2)*[1 0];

% Initialisation of the first pitch
r(1) = datasample(1:M,1);
omega_r(1) = omega(r(1));

for t = 2:T
    r(t) = datasample(1:M,1,'Weights',Z(r(t-1),:));
    omega_r(t) = omega(r(t));
    if r(t) == r(t-1)
        A = exp(-gamma)*[cos(omega_r(t)) -sin(omega_r(t)); 
                         sin(omega_r(t)) cos(omega_r(t))];
        [X(t,:), Y(t)] = lingauss_step(X(t-1,:),A,B,Q,R);
    else
       X(t,:) = mvnrnd(zeros(1,2),S);
       eta = mvnrnd(0,R);
       Y(t) = B*X(t,:)'+ eta;
    end
end

figure()
subplot(211)
plot(X(:,1));
subplot(212)
plot(r);

soundsc(X(:,1), Fs)

%% Pitch Tracking

Np = 10000; % Particals quantity
r0 = datasample(1:M, Np);
X = zeros(2,Np); 
for i = 1:Np
   X(:,i) = (mvnrnd(zeros(2,1),S));
end % Initialise the first X randomly
% particles = [X; R0]; % first particle
logweight = log((1/Np)*ones(1,Np)); % Weight initialisation

Xp = zeros(3,Np,T); % Table to stock the particles

for k = 1:T
    for j = 1:Np
        Prob = Z(r0(j),:);
        r_id(j) = datasample(1:M, 1, 'Weights', Prob);
        omega_r(j) = omega(r_id(j));
        A = exp(-gamma)*[cos(omega_r(j)) -sin(omega_r(j)); 
                         sin(omega_r(j)) cos(omega_r(j))];
        X(:,j) = (r_id(j)==r0(j))*(A*X(:,j) + mvnrnd(zeros(2,1),Q)') + (r_id(j)~=r0(j))*mvnrnd(zeros(2,1),S)';
        particles(:,j)=[X(:,j); r_id(j)];
        logY_X(j) = -0.5*log(2*pi*R)-((Y(k) - B*X(:,j))^2)/(2*R);
        logweight(j) = logweight(j) + logY_X(j);
    end
    r0 = r_id;
    logweight = logweight - log(sum(exp(logweight-max(logweight))));
    [w w_id] = max(logweight);
    %Xp(:,:,k) = particles;
    r_hat(k) = r_id(w_id);
    fprintf('Iteration %d: \n',k);
end

figure()
subplot(211)
plot(r_hat);
subplot(212)
plot(r);