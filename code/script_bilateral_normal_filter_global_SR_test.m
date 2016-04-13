function filteredNormalsFace = script_bilateral_normal_filter_global_SR_test(verts,faces,normalsFace,lamda)
% compute the matrix
nFaces  = size(normalsFace,1);
AdjacyMatrix = compute_dual_graph(faces,verts);
[I J] = find(AdjacyMatrix);
m = length(I);
[sumArea area] = compute_area_faces(verts,faces);
ii = [1:m 1:m]';
jj = [I;J];
vv = [ones(m, 1); -ones(m, 1)];
D = sparse(ii, jj, vv, m, nFaces);
% compute the weight
s = zeros(m,1);
for i = 1 : nFaces
    sum = 0;
    neigh = find(AdjacyMatrix(i,:));
    nNeigh = length(neigh);
    for j = 1 : nNeigh
        sum = sum + norm((normalsFace(i,:) - normalsFace(neigh(j),:)));
    end
    s(I==i) = sum;
end
% t =  norms(D * normalsFace, 2, 2);
% w = 1 ./ (s .* t);
w = 1 ./ s;
w1 = area / mean(area);
clear AdjacyMatrix ii jj vv;
%% L1 normal reconstruction
cvx_solver SDPT3;
n = nFaces;
nx0 = normalsFace(:,1);
ny0 = normalsFace(:,2);
nz0 = normalsFace(:,3);
cvx_begin
    variable nx(n);
    variable ny(n);
    variable nz(n);
    minimize(w' * norms(D * [nx ny nz],1,2) + lamda * w1' * sum_square([nx-nx0 ny-ny0 nz-nz0],2));
cvx_end
filteredNormalsFace = [nx ny nz];
% normalize the normal
for i = 1 : n
    filteredNormalsFace(i,:) = filteredNormalsFace(i,:) / norm(filteredNormalsFace(i,:));
end
