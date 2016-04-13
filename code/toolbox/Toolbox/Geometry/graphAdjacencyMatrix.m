function W = graphAdjacencyMatrix(F)

%%Construct the adjacency matrix of the triangular mesh graph 
%Input:  F ---the facts of the mesh
%Output: W ---the adjacency matrix
%%Example:
%[V F] = mRead();
%W = graphWeightMatrix(F);

%Hui Wang, wanghui19841109@gmail.com, Dec, 11,2011

[I J] = adjacencyMatrix(F);
w = zeros(size(I)) + 1;
W = sparse(I,J,w);
W = spones(W);

clear I;
clear J;
clear w;