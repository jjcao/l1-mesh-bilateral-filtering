function K = compute_normalization_factorK(fring,areas,Wc,Ws)
nFaces = size(areas,1);
K = zeros(nFaces,1);
for i = 1 : nFaces
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    sum = 0;
    for j = 1 : nNeighbors
        sum = sum + areas(neighbors(j)) * Wc(i,neighbors(j)) * Ws(i,neighbors(j));
    end
    K(i) = 1 / sum;
end
end
