function fring = compute_face_vertex_ring(faces)
%compute the face ring-faces share the same vertext with the given one
% Lnn 2012.10.25
nface = size(faces,1);
fring{nface} = [];
vert_face_ring = compute_vertex_face_ring(faces);
for i = 1 : nface
    ring_vert_1 = vert_face_ring{faces(i,1)};
    ring_vert_2 = vert_face_ring{faces(i,2)};
    ring_vert_3 = vert_face_ring{faces(i,3)};
    temp = unique([ring_vert_1 ring_vert_2 ring_vert_3]);
    temp = setdiff(temp,i);
    fring{i} = temp;
end
end