function [filteredNormalsFace filteredVerts MSAE] = compute_filtered_normals_verts_nnli(verts,faces,normalsFace_original,normalsFace,lamda,iteration)
iteration_vertexUpdating = 1;
MSAE = zeros(iteration,1);
filteredNormalsFace = normalsFace;
for i = 1 : iteration
    filteredNormalsFace = script_bilateral_normal_filter_global_SR(verts,faces,filteredNormalsFace,lamda);
    MSAE(i) = mean(acos(sum(filteredNormalsFace .* normalsFace_original,2)));
end
filteredVerts = compute_vertex_updating_Sun(verts,faces,filteredNormalsFace,iteration_vertexUpdating);
end