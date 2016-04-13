function S = compute_S(delta,normals)
S = diag(sum(delta.*normals,2));
end