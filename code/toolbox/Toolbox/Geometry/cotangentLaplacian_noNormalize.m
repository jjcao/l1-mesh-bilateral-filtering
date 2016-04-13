function L = cotangentLaplacian_noNormalize(V,F)

%%Construct the cot Laplacian L = 0.5*( W + W') 
%Input:  F ---the fact of the mesh
%Output: L ---the cot Laplacian
%%Example:
%[V F] = mRead();
%L = cotangentLaplacian_noNormalize(V,F);

%Hui Wang, Nov. 11, 2011

[I,J,Vr] = cotangentLaplacianMatrix(V,F);
Q = sparse(I,J,Vr);
W = 0.5*(Q + Q');
diagValue = sum(W,2);
D = sparse(1:length(diagValue),1:length(diagValue),diagValue);
L = D - W;
