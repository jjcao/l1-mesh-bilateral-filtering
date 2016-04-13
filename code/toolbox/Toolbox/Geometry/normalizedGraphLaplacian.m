function L = normalizedGraphLaplacian(F)

%%Construct the normalized graph Laplacian L = D^-0.5 * (D - W) * D^-0.5, seen Section 6.3 form Zhang hao's
%"Spectral Methods for Mesh Processing and Analysis" 2007
%Input:  F ---the fact of the mesh
%Output: L ---the normalized graph Laplacian
%%Example:
%[V F] = mRead();
%L = normalizedGraphLaplacian(F);

%Hui Wang, wanghui19841109@gmail.com, Dec. 11, 2011

W = graphAdjacencyMatrix(F);
n = size(W,1);
D = sparse(1:n, 1:n, sum(W,2));
K = D - W;
L = diag(sum(W,2).^-0.5) * K * diag(sum(W,2).^-0.5);
