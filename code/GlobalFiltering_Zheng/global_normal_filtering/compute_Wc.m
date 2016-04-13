function Wc = compute_Wc(centers,fring,sigmaC)
nCenters = size(centers,1);
Wc = sparse(nCenters,nCenters);
for i = 1 : nCenters
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        Wc(i,neighbors(j)) = exp(-(norm(centers(i,:) - centers(neighbors(j),:)))^2 / (2*sigmaC^2));
    end
end
end