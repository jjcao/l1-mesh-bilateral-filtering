function filteredNormals = compute_normals_filtered_DM(normalsFace,fring,Area,K,omega,lamda)
nFaces = size(normalsFace,1);
A = sparse(2 * nFaces,nFaces);
b = zeros(nFaces,3);
filteredNormals = zeros(nFaces,3);
for i = 1 : nFaces
    A(i,i) = sqrt(Area(i) * (1 - lamda));
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        A(i,neighbors(j)) = - sqrt(Area(i) * (1 - lamda)) * K(i) * omega(i,neighbors(j));
    end
    b(i,:) = [0 0 0];
end
for i = nFaces + 1 : 2 * nFaces
    A(i,i - nFaces) = sqrt(lamda * Area(i - nFaces));
    b(i,:) = sqrt(lamda * Area(i - nFaces)) * normalsFace(i - nFaces,:);
end
filteredNormals(:,1) = A \ b(:,1);
filteredNormals(:,2) = A \ b(:,2);
filteredNormals(:,3) = A \ b(:,3);
for i = 1 : nFaces
    filteredNormals(i,:) = filteredNormals(i,:) / norm(filteredNormals(i,:));
end
end