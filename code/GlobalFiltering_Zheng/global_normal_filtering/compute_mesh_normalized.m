function vertsNormalized = compute_mesh_normalized(verts,rect)
nVerts = size(verts,1);
vertsNormalized = zeros(nVerts,3);
m = min(verts,[],1);
M = max(verts,[],1);
diagLine_ori = norm(M - m);
diagLine_dst = sqrt((rect(2)-rect(1)).^2 + (rect(4)-rect(3)).^2 + (rect(6)-rect(5)).^2);
K = diagLine_dst / diagLine_ori;
B_x = rect(1) - K * m(1);
B_y = rect(3) - K * m(2);
B_z = rect(5) - K * m(3);
vertsNormalized(:,1) = K * verts(:,1) + B_x;
vertsNormalized(:,2) = K * verts(:,2) + B_y;
vertsNormalized(:,3) = K * verts(:,3) + B_z;
end