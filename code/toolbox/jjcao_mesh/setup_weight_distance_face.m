function [] = setup_weight_distance_face(vertices, face,is_cvs)
%   setup_weight_distance_face - setup distance weights for vertices in
%   face
%
%   Copyright (c) 2008 JJCAO
i=face(1);j=face(2);k=face(3);
vi = vertices(i,:);
vj = vertices(j,:);
vk = vertices(k,:);
global L;
if(is_cvs(i)==0)
    L(i,j) = sqrt((vi-vj)*(vi-vj)');
    L(i,k) = sqrt((vi-vk)*(vi-vk)');
end
if(is_cvs(j)==0)
    L(j,i) = sqrt((vi-vj)*(vi-vj)');
    L(j,k) = sqrt((vj-vk)*(vj-vk)');
end
if(is_cvs(k)==0)
    L(k,j) = sqrt((vj-vk)*(vj-vk)');
    L(k,i) = sqrt((vi-vk)*(vi-vk)');
end