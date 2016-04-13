function filteredNormalsFace = script_bilateral_normal_filter_local(verts,faces,normalsFace,flagRing,sigmaS)
centersFace = compute_face_centers(verts,faces);   
areasFace = compute_area_faces(verts,faces); 
if(flagRing == 1)
%I-neighbor
fring = compute_face_ring(faces);
else
%II-neighbor
fring = compute_face_vertex_ring(faces);
end
sigmaC = compute_sigmaC(fring,centersFace);
[K,omega] = compute_K_omega(centersFace,fring,sigmaC,normalsFace,sigmaS,areasFace);
omega = omega';
% local and iterative scheme
filteredNormalsFace = (omega * normalsFace) .* repmat(K,1,3);
for i = 1 : size(centersFace,1)
    filteredNormalsFace(i,:) = filteredNormalsFace(i,:) / norm(filteredNormalsFace(i,:));
end
end