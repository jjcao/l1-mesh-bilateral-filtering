function filteredVerts = compute_vertex_updating_WSF(verts,faces,normalsVert,filteredNormalsFace)
filteredNormalsVert = compute_vertex_normal_new(verts,faces,filteredNormalsFace);
N_weight = compute_N(verts,faces,normalsVert);
delta = N_weight * verts;
NS = compute_S(delta,normalsVert);
delta_new = NS * filteredNormalsVert;
nControl = 1;
[control_A control_b] = compute_control_points(verts,NS,nControl);
A = [N_weight;control_A];
b = [delta_new;control_b];
filteredVerts = A \ b;
end