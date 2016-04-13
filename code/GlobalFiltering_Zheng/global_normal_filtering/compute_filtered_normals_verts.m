function [filteredNormalsFace filteredVerts] = compute_filtered_normals_verts(verts,faces,normalsFace,flagRing,flagFilter,sigmaS,sigmaC,lamda,lamda_Pre,iteration_reweighted)
iteration_vertexUpdating = 30;
if (flagFilter == 0)
    filteredNormalsFace = script_bilateral_normal_filter_local(verts,faces,normalsFace,flagRing,sigmaS);
    filteredVerts = compute_vertex_updating_Sun(verts,faces,filteredNormalsFace,iteration_vertexUpdating);
elseif (flagFilter == 1)
    filteredNormalsFace = script_bilateral_normal_filter_global(verts,faces,normalsFace,flagRing,sigmaS,lamda);
    filteredVerts = compute_vertex_updating_Sun(verts,faces,filteredNormalsFace,iteration_vertexUpdating);
elseif (flagFilter == 2)
    centersFace = compute_face_centers(verts,faces);
    fring = compute_face_vertex_ring(faces);
    deta_c = compute_sigmaC(fring,centersFace);
    radius = 10;
    deta_s = 0.1;
    n = 1;
    filteredVerts = BilaterFilteriing1(verts, faces, radius, deta_c, deta_s, n);
    [filteredNormalsVert, filteredNormalsFace] = compute_vertex_normal(filteredVerts,faces);
else
    filteredNormalsFace = script_bilateral_normal_filter_global_RR(verts,faces,normalsFace,flagRing,sigmaS,sigmaC,lamda,lamda_Pre,iteration_reweighted);
    filteredVerts = compute_vertex_updating_Sun(verts,faces,filteredNormalsFace,iteration_vertexUpdating);
end