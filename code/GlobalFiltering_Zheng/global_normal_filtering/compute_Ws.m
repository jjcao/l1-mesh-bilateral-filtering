function Ws = compute_Ws(normals,fring,sigmaS)
nNormals = size(normals,1);
Ws = sparse(nNormals,nNormals);
for i = 1 : nNormals
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        Ws(i,neighbors(j)) = exp(-(norm(normals(i,:) - normals(neighbors(j),:)))^2 / (2*sigmaS^2));
    end
end
end