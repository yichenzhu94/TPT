%function T = CalculateT(KD,CvD, Nd)
function TD = CalculateTD(KDvec,CvD, Nd)


% component-wise form
% for i = 1 : Nd
%     for j = 1 : Nd
%          T(i,j) = ones(1,Nd)*(KD(:,:,(i-1)*Nd+j).*CvD')*ones(Nd,1); 
%     end
% end

% vectorized inner product (fast)
TD = reshape(KDvec'*reshape(CvD',[],1),Nd,Nd);