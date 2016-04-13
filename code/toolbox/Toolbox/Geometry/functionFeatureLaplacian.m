function L = functionFeatureLaplacian(V,F,fun)

%Hui wang, Oct. 8, 2010, www.huiwang.jimdo.com

[I,J,R] = FFPLaplacian(V,F,fun);
K = sparse(I,J,R);
n = size(V,1);
K1 = sparse(1:n,1:n,sum(K,2).^-1) * K;
L = speye(n) - K1;