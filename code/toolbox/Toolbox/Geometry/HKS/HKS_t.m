function hks_t = HKS_t(evecs, evals, A, t, scale)
%Compute the HKS at the time t, acooresponding to the paper "A Concise and Provably Informative Multi-Scale Signature
%Based on Heat Diffusion", this code is from Jian Sun's homepage
% INPUTS
%  evecs:  ith each column in this matrix is the ith eigenfunction of the Laplace-Beltrami operator
%  evals:  ith element in this vector is the ith eigenvalue of the Laplace-Beltrami operator
%  A: ith element in this vector is the area associated with the ith vertex
%  t:      the time scale 
% OUTPUTS
%  hks_t: heat kernel signature restricted to the time scale t

%Hui Wang, Nov. 11, 2011, wanghui198441109@gmail.com


if scale == true, 
   hks_t = abs( evecs(:, 2:end) ).^2 * exp( ( abs(evals(2)) - abs(evals(2:end)) )  * t);
   Am = sparse([1:length(A)], [1:length(A)], A);
   colsum = sum(Am*hks_t);
   scale = 1.0 / colsum; 
   scalem = sparse([1:length(scale)], [1:length(scale)], scale);
   hks_t = hks_t * scalem;
else
   hks_t = abs( evecs(:, 2:end) ).^2 * exp( - abs(evals(2:end)) * t);
end 

