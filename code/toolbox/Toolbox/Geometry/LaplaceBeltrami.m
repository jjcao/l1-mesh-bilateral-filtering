function L = LaplaceBeltrami(V,F)

%%Construct the Laplace-Beltriami matrix acoording to "Discrete Differential-Geometry Operators
%for Triangulated 2-Manifolds" by Mark Meyer 2002
%Input:  F ---the fact of the mesh
%Output: L ---the cot Laplacian
%%Example:
%[V F] = mRead();
%L = LaplaceBeltrami(V,F);

%Hui Wang, Jan. 17, 2010

K = cotangentLaplacian_noNormalize(V,F);
area = MixedArea(V,F);
D = sparse(1:length(area),1:length(area),area.^-1);
L = D * K;
