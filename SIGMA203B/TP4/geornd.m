function rnd = geornd (n, p)

output = zeros(1,n);
conti = 1+ output ;
while(sum(conti) >0)
   draw = rand(1, n) ;
   echecs = draw > p ;
   succes = draw <=p ;
   output(echecs) = output(echecs)+1 ;
   conti(succes) = 0 ;
end
rnd = output;
end
% 
% if (nargin < 1)
%   print_usage ();
% end
% 
% if (nargin == 1)
%   sz = size (p);
% elseif (nargin == 2)
%   if (isscalar (varargin{1}) && varargin{1} >= 0)
%     sz = [varargin{1}, varargin{1}];
%   elseif (isrow (varargin{1}) && all (varargin{1} >= 0))
%     sz = varargin{1};
%   else
%     error ("geornd: dimension vector must be row vector of non-negative integers");
%   endif
% elseif (nargin > 2)
%   if (any (cellfun (@(x) (!isscalar (x) || x < 0), varargin)))
%     error ("geornd: dimensions must be non-negative integers");
%   endif
%   sz = [varargin{:}];
% endif
% 
% if (!isscalar (p) && !isequal (size (p), sz))
%   error ("geornd: P must be scalar or of size SZ");
% endif
% 
% if (iscomplex (p))
%   error ("geornd: P must not be complex");
% endif
% 
% if (isa (p, "single"))
%   cls = "single";
% else
%   cls = "double";
% endif
% 
% if (isscalar (p))
%   if (p > 0 && p < 1);
%     rnd = floor (- rande (sz, cls) ./ log (1 - p));
%   elseif (p == 0)
%     rnd = Inf (sz, cls);
%   elseif (p == 1)
%     rnd = zeros (sz, cls);
%   elseif (p < 0 || p > 1)
%     rnd = NaN (sz, cls);
%   end
%   else
%     rnd = floor (- rande (sz, cls) ./ log (1 - p));
% 
%     k = !(p >= 0) | !(p <= 1);
%     rnd(k) = NaN;
% 
%     k = (p == 0);
%     rnd(k) = Inf;
%   endif
% 
% end
