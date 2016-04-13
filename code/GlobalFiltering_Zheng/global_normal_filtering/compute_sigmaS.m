function sigmaS = compute_sigmaS(fring,normalsFace)
nFaces = size(normalsFace,1);
sum = 0;
num = 0;
for i = 1 : nFaces
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        sum = sum + norm((normalsFace(i,:) - normalsFace(neighbors(j),:)));
        num = num + 1;
    end
end
sigmaS = sum / num;
end