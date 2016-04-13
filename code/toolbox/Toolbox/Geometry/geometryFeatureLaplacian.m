function L = geometryFeatureLaplacian(V,F,para)

%Hui wang, Oct. 6, 2010, www.huiwang.jimdo.com

normal = vertexNormals(V,F);
M = meanMatrix(F,1);


normal1 = M * normal;
length = sqrt(sum(normal1 .^ 2, 2));
n = size(V, 1);
MM = sparse(1:n, 1:n, length .^ -1);
normal1 = MM * normal1;


[I,J,R] = GFPLaplacian(V, F, normal1, para);
K = sparse(I,J,0 * R + 1);


n = size(V,1);
weightSum = sum(K,2);
K1 = sparse(1:n,1:n,weightSum.^-1) * K;
L = speye(n) - K1;