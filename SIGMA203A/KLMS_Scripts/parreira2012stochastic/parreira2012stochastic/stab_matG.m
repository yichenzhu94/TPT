%===============================================================================
% This function calculates the whole matrix G. Note that we does not used
% it to test the stability of the klms filter as we used the Gerschgorin
% disk approach and, as an alternative, a conjecture that directly gives
% the largest eigenvalue of G in absolute value.
%
% See the notations in:
%
% W. D. Parreira, J.-C. M. Bermudez, C. Richard, and J.-Y. Tourneret, "Stochastic
% behavior analysis of the Gaussian kernel-least-mean-square algorithm,"
% IEEE Transactions on signal processing, 2012, vol. 60, n° 5, p.
% 2208-2222.
%
% contact: cedric.richard@unice.fr
% version: 7 november 2012
%
%===============================================================================


function G = stab_matG(eta,nu,r,M)



%% Calculation of the different entries involved in the definition of the matrix G
% It is required for characterizing the Gaussian KLMS
% filter
rmd = r(1);
rod = r(2);
G1 = 0.5*(1-2*eta*rmd+2*eta^2*nu(3));
G2 = eta^2*nu(4);
G3 = eta^2*nu(2)-eta*rod;
G4 = 0.5*(2*eta^2*nu(4)-eta*rod);
G5 = eta^2*nu(5);
G6 = 1-2*eta*rmd+eta^2*nu(1);
G7 = eta^2*nu(3);


%% Calculation of the matrix G
for i=1:M,
    for j=1:M,
        for l=1:M,
            for p=1:M;
                
                if (i~=j)&&(i==l)&&(j==p), acc=G1; end
                if (i~=j)&&(i==p)&&(j==l), acc=G1; end
                if (i~=j)&&(l==p)&&(p~=i)&&(p~=j), acc=G2; end
                if (i~=j)&&(i==l)&&(i==p), acc=G3; end
                if (i~=j)&&(j==l)&&(j==p), acc=G3; end
                if (i~=j)&&(l==i)&&(p~=i)&&(p~=j), acc=G4; end
                if (i~=j)&&(l==j)&&(p~=i)&&(p~=j), acc=G4; end
                if (i~=j)&&(p==i)&&(l~=i)&&(l~=j), acc=G4; end
                if (i~=j)&&(p==j)&&(l~=i)&&(l~=j), acc=G4; end
                if (i~=j)&&(l~=i)&&(l~=j)&&(p~=i)&&(p~=j)&&(p~=l), acc=G5; end
                
                if (i==j)&&(l==i)&&(p==j), acc=G6; end
                if (i==j)&&(l==p)&&(p~=j), acc=G7; end
                if (i==j)&&(p==i)&&(l~=j), acc=G3; end
                if (i==j)&&(l==i)&&(p~=j), acc=G3; end
                if (i==j)&&(p~=i)&&(l~=j)&&(p~=l), acc=G2; end
                
                H(l,p) = acc;
                G((i-1)*M+j,(l-1)*M+p) = acc;
            end
        end
    end
end





