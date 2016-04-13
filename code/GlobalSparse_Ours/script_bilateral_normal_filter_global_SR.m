function filteredNormalsFace = script_bilateral_normal_filter_global_SR(verts,faces,normalsFace,lamda)
nFaces  = size(normalsFace,1);
AdjacyMatrix=compute_dual_graph(faces,verts);
[I,J]=find(AdjacyMatrix);
N_graph=[I J];
E = N_graph;
m = size(E,1);
w = ones(m,1);
w1=ones(nFaces,1);
ii = [1:m 1:m]';
jj = [E(:, 1); E(:, 2)];
vv = [ones(m, 1); -ones(m, 1)];
D = sparse(ii, jj, vv,m,nFaces);
clear N_graph AdjacyMatrix I J ii jj vv E;
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
for i = 1:n
    filteredNormalsFace(i,:) = filteredNormalsFace(i,:) / norm(filteredNormalsFace(i,:));
end