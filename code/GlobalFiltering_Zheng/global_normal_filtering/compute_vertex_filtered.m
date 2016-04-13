function V = compute_vertex_filtered(N,delta)
nVerts = size(N,1);
V = zeros(nVerts,3);
V(:,1) = N \ delta(:,1);
V(:,2) = N \ delta(:,2);
V(:,3) = N \ delta(:,3);
end