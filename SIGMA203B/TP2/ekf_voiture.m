function [M, Parray] = ekf_voiture(Y,m_0,P_0,L,sigma,tau,h)
 % Filtre de Kalman pour la voiture a capteurs directionnels
 % Filtre sequentiellement les observations Y 
 % pour reconstruire le signal X
 %%%
 % ARGUMENTS: 
 % Y: les observations : une matrice T * 2
 % m_0: vecteur colonne 2 * 1 : moyenne a priori de l'etat initial 
 % P_0: matrice 2*2: variance a priori de l'instant initial
 % L : ecartement des deux capteurs sur l'axe 0y
 % sigma, tau: bruits sur l'etat et l'observation (cf pendule_step.m)
 % h: pas de discretisation 
 %%%
 % VALEUR:
 % M: Matrice T * 4: les moyennes a posteriori
 % Parray:  Array de dimension 4*4*T  les matrices de covariances 
 %          des lois de filtrages successives
  dim_state = 4;
  dim_obs = 2;
  T = size(Y,1);
  A = [ 1, 0, h, 0 ;
	    0, 1, 0, h ; 
	    0, 0, 1, 0 ;
	    0, 0, 0, 1 ] ;

  Q = sigma^2 *  [ h^3/3 , 0    , h^2/2 , 0     ;
                   0,      h^3/3, 0     , h^2/2 ; 
                   h^2/2,   0   ,  h    ,   0   ;
                   0     , h^2/2     , 0     , h ] ;

  R = tau^2 * eye(dim_obs);
  P = P_0; 
  m = reshape(m_0,dim_state,1) ;
  M = zeros(T,dim_state);
  Parray = zeros(dim_state,dim_state, T);
  syms Z1 Z2 V1 V2;
  Y1 = atan(Z2/Z1);
  Y2 = atan((Z2-L)/Z1);
  B = jacobian([Y1,Y2],[Z1,Z2,V1,V2]);
  for k=1:T
    %%%%%%%%%%%%%%%%%
    % prediction : comme dans   Kalman (equation  lineaire)
    mpred = A*m;
    Ppred = A*P*A' + Q;
    % mise a jour
    % Differentielle de g au point mpred
%     r1 = mpred(1)^2 + mpred(2)^2;
%     r2 = mpred(1)^2 + (mpred(2) - L)^2;
    Z1 = mpred(1);
    Z2 = mpred(2);
    B = double(subs(B));
    ypred = [atan(mpred(2)/mpred(1)),atan((mpred(2)-L)/mpred(1))];
    
    [mu, Pu] = ekf_update(Y(k,:),  mpred , Ppred,ypred, A, ...
			  B, R);
    % reaffectation de l'etat courant
    m = mu; 
    P = Pu;
	% stockage
    M(k,:) = mu';
    Parray(:,:,k) = P;
  end
end
