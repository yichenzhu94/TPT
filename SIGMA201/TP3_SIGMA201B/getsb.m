function bd=getsb(m,k,j)
%GETSB returns a wavelet subband
%   subband = getsb(wtCoeff, subbandIdx, decLevels)
%   gets the subband number SUBBANDIDX from the matrix of WT coefficients
%   with DECLEVELS decomposition levels.
%   
%   Example
%   wtCoeff = 
%   |----|----|--------|----------------|
%   | 1  | 3  |        |                |
%   |----|----|    6   |                |
%   | 2  | 4  |        |                |
%   |----|----|--------|       9        |
%   |         |        |                |
%   |    5    |   7    |                |
%   |         |        |                |
%   |---------|--------|----------------|
%   |                  |                |
%   |                  |                |
%   |                  |                |
%   |         8        |      10        |
%   |                  |                |
%   |                  |                |
%   |                  |                |
%   |------------------|----------------|
%
%   In this case, getsb(wtCoeff, 1, 3) would return the approximation
%   subband,  getsb(wtCoeff, 2, 3) would return the coarsest horizontal
%   detail subband, etc., getsb(wtCoeff, 10, 3) would return the largest
%   diagonal detail subband (HH)
%
%   (c) 2008-2014 M.Cagnazzo, Telecom-ParisTech
%


if k > 3*j+1
    bd = 0;
else
    n=length(m);
    [qa,qb]=idxsb(k,n,j);
    bd=m(qa,qb);
end