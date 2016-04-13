function areas = area_1_ring(vertices,faces, rings)

if exist('rings','var') ==0
    rings = compute_vertex_face_ring(faces);
end

areas = zeros(length(rings),1);
n = size(areas,1);
for i = 1:n
    ring = rings{i};
    for b = ring
        bf = faces(b,:);
        vi = vertices(bf(1),:); vj = vertices(bf(2),:); vk = vertices(bf(3),:);
        areas(i) = areas(i) + 0.5 * norm(cross(vi-vk,vi-vj));
    end
end