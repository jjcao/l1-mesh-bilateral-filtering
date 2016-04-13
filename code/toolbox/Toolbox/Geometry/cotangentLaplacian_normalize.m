function L = cotangentLaplacian_normalize(V,F)

%%Construct the cot Laplacian L = 0.5*( W + W'), 
%Input:  F ---the fact of the mesh
%Output: L ---the cot Laplacian
%%Example:
%[V F] = mRead();
%L = cotangentLaplacian_normalize(V,F);

%Shengfa Wang %-- 09-12-27 обнГ6:32 --%


[I,J,Vr] = cotangentLaplacianMatrix(V,F);
Q = sparse(I,J,Vr);
W = 0.5*(Q + Q');
D = diag(sum(W,2));
K = D - W;
L = diag(sum(W,2).^-1) * K;