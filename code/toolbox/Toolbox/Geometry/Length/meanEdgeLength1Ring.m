function meanLength = meanEdgeLength1Ring(vertex,facets)
%Compute the mean length of mesh
%%Input:
%vertex--The coordinates of the vertex of triangular mesh
%facets--The facets of the triangular mesh
%%Output:
%meanLength--The mean of the edge length

%Hui Wang, Nov. 1, 2011, wanghui19841109@gmail.com

W = graphWeightMatrix(facets);

[row,col] = find(W);
edge = vertex(row,:) - vertex(col,:);
edgeLength = sqrt(sum(edge .^2,2));

M = sparse(row, col, edgeLength);

meanLength = mean(M, 2);