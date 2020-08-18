% *************************************************************************
%
% Simulations reported in the following paper:
% 
% W. Gao, J. Chen, C. Richard, J. Huang and R. Flamary, "Kernel LMS with 
% forward-backward splitting for dicitonary learning", in Proc. IEEE ICASSP, May. 2013.
%
% contact: cedric.richard@unice.fr; gao_wei@mail.nwpu.edu.cn
% version: 26 March 2013
% 
% *************************************************************************


example1: run this file to perform simulation 1 in the Icassp paper
example2: run this file to perform simulation 2 in the Icassp paper

klms_cs:    KLMS with coherence criterion
klms_csl1:  KLMS with coherence criterion and L1-norm 
                 sparsification of the dictionary
klms_csal1: KLMS with coherence criterion and reweighed L1-norm 
                 sparsification of the dictionary
krls_cs:    KRLS with coherence criterion

richardbench: benchmark used for example 1
nlchnlbench:  benchmark used for example 2