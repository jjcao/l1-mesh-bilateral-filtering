function L = graphLaplacian(F)

%%Construct the graph Laplacian L = D - W, seen Section 6.3 form Zhang hao's
%"Spectral Methods for Mesh Processing and Analysis" 2007
%Input:  F ---the fact of the mesh
%Output: L ---the graph Laplacian
%%Example:
%[V F] = mRead();
%L = graphLaplacian(F);

%Hui Wang, wanghui19841109@gmail.com, Dec. 11, 2011

W = graphAdjacencyMatrix(F);
L = diag(sum(W,2)) - W;

