function hk = heatKernel(evecs, evals, i, t)
%Compute the heat kernel at the time t form the single source point i, acooresponding to the paper "A Concise and Provably Informative Multi-Scale Signature
%Based on Heat Diffusion"
% Input:
%  evecs: ith each column in this matrix is the ith eigenfunction of the Laplace-Beltrami operator
%  evals: ith element in this vector is the ith eigenvalue of the Laplace-Beltrami operator
%  i: the index of the single source point
%  t: the time scale 
% Output:
%  hk: heat kernel restricted to the time scale t from the single source point 

%Hui Wang, Dec. 12, 2011, wanghui198441109@gmail.com

m = size(evecs, 2);
M = sparse(1:m, 1:m, evecs(i, :));
evecs1 = evecs * M;

hk = evecs1 * exp(-1.0 * evals * t);