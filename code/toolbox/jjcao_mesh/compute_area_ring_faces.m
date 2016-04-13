function areas = compute_area_ring_faces(vertices,faces, rings)
% compute_area_ring_faces - compute area for 1-ring faces of each vertex.
%
%   areas = compute_area_ring_faces(vertices,faces, rings);
%
%   Copyright (c) 2009 JJCAO

if exist('rings','var') ==0
    rings = compute_vertex_face_ring(faces);
end

areas = zeros(size(rings,2),1);
n = size(areas,1);
for i = 1:n
    ring = rings{i};
    for b = ring
        bf = faces(b,:);
        vi = vertices(bf(1),:); vj = vertices(bf(2),:); vk = vertices(bf(3),:);
        areas(i) = areas(i) + 0.5 * norm(cross(vi-vk,vi-vj));
    end
end