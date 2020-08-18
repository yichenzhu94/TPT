
%================================================================
% KERNEL: kernel for kernel-based methods such as SVM, KFD, etc.
%
% function k=kernel(ker,u,v,varargin);
%
% inputs of the function
% ker      : kernel type; see below
% u,v      : kernel arguments (row-wise data)
% varargin : parameters of the kernel, e.g., the degree of polynomial kernel
%
% output of the function
% k   : kernel value
%
% Remark
% The arguments u and v can be matrices. 
% Then we have: k(i,j)=ker(u(i,:),v(j,:))
%
%  Values for ker: 'linear'  -
%                  'poly'    - p1 is degree of polynomial
%                  'rbf'     - p1 is width of rbfs (sigma)
%                  'sigmoid' - p1 is scale, p2 is offset
%                  'erbf'    - p1 is width of rbfs (sigma)
%===============================================================================

function k = kernel(ker,u,v,varargin)

p1=[];
p2=[];

% check correct number of arguments
if (nargin < 1) 
     help svkernel
 elseif (nargin==4),
     p1=varargin{1};
 elseif (nargin==5),
     p1=varargin{1};
     p2=varargin{2};
 end

% compute the kernel values
switch lower(ker)
    case 'linear'
        k = real(u*v');
    case 'mono'
        if isempty(p1), p1=4; end
        k = (u*v').^p1;
        % normalization to have ker(u,u)=1 for all u (optional)
        % k = k./((sum(u.^2,2))*(sum(v.^2,2)').^(p1/2)); 
    case 'poly'
        if isempty(p1), p1=4; end
        k = (u*v'+1).^p1;
        % normalization to have ker(u,u)=1 for all u (optional)
        % k = k./((sum(u.^2,2)+1)*(sum(v.^2,2)'+1).^(p1/2)); 
    case 'rbf'
        if isempty(p1), p1=2.25; end
        k = exp(-(dist(u,v').^2)./(2*p1^2));
    case 'erbf'
        if isempty(p1), p1=1; end
        for n=1:size(u,1),
            k(n,:)=exp(-sqrt(sum((ones(size(v,1),1)*u(n,:)-v).^2,2)')/(p1));
        end
    case 'sigmoid'
        if isempty(p1), p1=1; end
        if isempty(p2), p2=1; end
        k = tanh(p1*u*v'/size(u,2)+p2);
 end
