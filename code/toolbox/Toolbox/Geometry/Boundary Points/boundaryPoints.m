function index = boundaryPoints(F) 
%Find the boundary points of the triangle mesh
%Example:[V, F] = mRead;
%index = boundaryPoints(F)

%Hui Wang, Dec. 12, 2011, wanghui19841109@gmail.com

[I, J] = adjacencyMatrix(F);
W = sparse(I, J, 0 * I + 1);
[i, j] = find(W == 1);

index = [i; j];
index = unique(index);