function zeta = compute_zeta(areas)
nFaces = size(areas,1);
zeta = zeros(nFaces,nFaces);
for i = 1 : nFaces
    zeta(:,i) = areas(i) * ones(nFaces,1); 
end
end