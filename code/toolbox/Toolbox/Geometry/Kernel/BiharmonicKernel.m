function f = BiharmonicKernel(L, Area, center_id, t)
%Compute the Biharmonic kenel based on the paper "Multiscale Biharmonic
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
Q = [sparse(n, 3 * n); 
     sparse(n, 3 * n); 
     sparse(n, 2 * n), sparse(1 : n, 1 : n, Area .^ -1)];
c = sparse(3 * n, 1);
a = [Area', sparse(1, 2 * n); 
     sparse(1, n), Area', sparse(1, n);
     speye(n), speye(n), sparse(n, n);
     -1.0 * speye(n), speye(n), sparse(n, n);
     L, sparse(n, n), -1.0 * speye(n)];
 blc = [0, -Inf, sparse(1, 3 * n)]';
 buc = [0, t, Inf + sparse(1, 2 * n), sparse(1, n)]';
 blx = sparse(3 * n, 1) - Inf;
 blx(center_id) = 1.0;
 blx((n + 1) : (2 * n)) = 0;
 bux = Inf + sparse(3 * n, 1);
 bux(center_id) = 1.0;
 
%Optimize the problem.
[res] = mskqpopt(Q, c, a, blc, buc, blx, bux);
%get the primal solution.
f = res.sol.itr.xx(1 : n);
