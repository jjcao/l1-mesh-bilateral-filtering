function filteredNormalsFace = script_bilateral_normal_filter_global(verts,faces,normalsFace,flagRing,sigmaS,lamda)
centersFace = compute_face_centers(verts,faces);   
[sumArea areasFace] = compute_area_faces(verts,faces); 
Area = areasFace / mean(areasFace);
if(flagRing == 1)
%I-neighbor
fring = compute_face_ring(faces);
%II-I neighbor
% fring = compute_face_ring_II_I(faces);
else
%II-neighbor
fring = compute_face_vertex_ring(faces);
%II-II neighbor
% fring = compute_face_ring_II_II(faces);
end
sigmaC = compute_sigmaC(fring,centersFace);
[K,omega] = compute_K_omega(centersFace,fring,sigmaC,normalsFace,sigmaS,areasFace);
omega = omega';
% direct method by left divide
filteredNormalsFace = compute_normals_filtered_DM(normalsFace,fring,Area,K,omega,lamda);
end