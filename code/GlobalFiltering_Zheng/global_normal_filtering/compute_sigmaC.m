function sigmaC = compute_sigmaC(fring,centers)
nCenters = size(centers,1);
sum = 0;
num = 0;
for i = 1 : nCenters
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        sum = sum + norm((centers(i,:) - centers(neighbors(j),:)));
        num = num + 1;
    end
end
sigmaC = sum / num;
end