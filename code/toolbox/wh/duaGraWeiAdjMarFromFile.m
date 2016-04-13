function W = duaGraWeiAdjMarFromFile(V, F, ita, deta)

%Compute the dual Graph Weight Adjacency Matrix From File, the weight is
%refered as SIGGRAOH 2003 paper, "Hierarchical Mesh Decomposition using
%Fuzzy Clustering and Cuts"
%Input:
%ita---The weight for the convex dihedral angel, 0.1=<ita<=0.2
%deta--The weight for the trade off between the geodestic and angle
%distances, 0.01=<deta<=0.05
%Output:
%W--The sparse weighted adjacency matrix of the triangle mesh from the file

%Example: W = dualAdjacencyMatrixFromFile(0.1,0.1);


[I, J, AD, Concave, ED, Dist, Vi, Vj] = dualGraphInformation(V, F);

ConcaveWeight = ita + 0 * Concave;
ConcaveWeight(find(Concave < 0)) = 1.0;
AD1 = AD .* ConcaveWeight;
% Distance = (1.0 - deta) * Dist / mean(Dist) + deta * AD1 / mean(AD1);
Distance = Dist;


W = sparse([I,J],[J,I],[Distance, Distance]);

