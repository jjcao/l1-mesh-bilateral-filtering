function centers = compute_face_centers(verts,faces)
centers = (verts(faces(:,1),:) + verts(faces(:,2),:) + verts(faces(:,3),:)) / 3;
end