function hodge = edge_rot_90(edges, normals, Mhe, Mifs)
% rotate edge 90 degree anti-clockwise around normal , by cross product with normal.
svid = Mhe.edge_orig(edges);
dvid = Mhe.edge_dest(edges);
sv = Mifs.vertex_coords(svid);
dv = Mifs.vertex_coords(dvid);;
hodge = cross(normals,dv-sv,2);