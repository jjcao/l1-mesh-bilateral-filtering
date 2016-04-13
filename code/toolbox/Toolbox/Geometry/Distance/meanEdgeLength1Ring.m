function meanLength = meanEdgeLength1Ring(vertex,facets)
%Compute the mean length of mesh of 1-ring
%%Input:
%vertex--The coordinates of the vertex of triangular mesh
%facets--The facets of the triangular mesh
%%Output:
%meanLength--The mean of the edge length of 1-ring

%Hui Wang, Dec. 12, 2011, wanghui19841109@gmail.com

W = graphAdjacencyMatrix(facets);

[row,col] = find(W);
edge = vertex(row,:) - vertex(col,:);
edgeLength = sqrt(sum(edge .^2,2));

M = sparse(row, col, edgeLength);

meanLength = mean(M, 2);