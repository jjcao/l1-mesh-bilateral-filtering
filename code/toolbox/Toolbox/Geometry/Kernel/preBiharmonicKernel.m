function f = preBiharmonicKernel(L, Area, center_id, t)
%Compute the pre-Biharmonic kenel based on the paper "Multiscale Biharmonic
%Kernels (SGP 2011)" using the Mosek 6.0
%Input:
%L:--the conformal n * n aplacian matrix with cotangent weights
%Area:--the verter cell area, n * 1 vector
%center_id:--the index of the center vertex
%t:--the parameter for the support
%Output:
%f--the kernel center at k-th vertex

%Hui Wang, Nov. 15, 2011, www.huiwang.jimdo.com

n = size(L, 1);

%fill out matrices for MOSEK
Q = [sparse(n, 2 * n);  
     sparse(n, n), sparse(1 : n, 1 : n, Area .^ -1)];
c = sparse(2 * n, 1);
a = [Area', sparse(1, n); 
     L, -1.0 * speye(n)];
 blc = [0, sparse(1, n)]';
 buc = [t, sparse(1, n)]';
 blx = sparse(2 * n, 1) - Inf;
 blx(1 : n) = 0;
 blx(center_id) = 1.0;

 bux = Inf + sparse(2 * n, 1);
 bux(center_id) = 1.0;
 
%Optimize the problem.
[res] = mskqpopt(Q, c, a, blc, buc, blx, bux);
%get the primal solution.
f = res.sol.itr.xx(1 : n);