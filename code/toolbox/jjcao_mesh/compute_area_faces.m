function [area areas] = compute_area_faces(vertices,faces)
%for trianglar mesh only
areas = zeros(size(faces,1),1);
n = size(areas,1);
for i = 1:n
    vi = vertices(faces(i,1),:); vj = vertices(faces(i,2),:); vk =vertices(faces(i,3),:);
    areas(i) = 0.5 * norm(cross(vi-vk,vi-vj));
end
area = sum(areas);