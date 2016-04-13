function W = duaGraWeiAdjMarFromFile(ita,deta)

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

%Hui wang, wanghui19841109@gmail.com, Dec, 11, 2011

[f, pathname,FilterIndex] = uigetfile({'*.off','*.off Files'},'Pick a file');
file = [pathname,f];

if FilterIndex == 1
  [I,J,angleDistance,geodesticDistance] = duaGraWeiAdjMar(file,ita);
else
    error('The file is null!');
    return;
end

AD = angleDistance;
GD = geodesticDistance;
if mean(angleDistance) > 1.0000e-010
   AD = 1.0 / mean(angleDistance) * angleDistance;
end
if mean(geodesticDistance) > 1.0000e-010
  GD = 1.0 / mean(geodesticDistance) * geodesticDistance;
end

distance = deta * GD + (1.0 - deta) * AD;
n = max([max(I),max(J)]);
w = sparse(I,J,distance,n,n);

W = w + w';
