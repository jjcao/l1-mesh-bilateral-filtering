function []=setup_weight_conformal_ring(i,vertices,faces,ring)
%   setup_weight_conformal_ring - setup conformal weights for vertex i
%
%   Copyright (c) 2008 JJCAO
global L;
for b = ring
    % b is a face adjacent to a
    bf = faces(b,:);
    % compute complementary vertices
    if bf(1)==i
        v = bf(2:3);
    elseif bf(2)==i
        v = bf([3 1]);
    elseif bf(3)==i
        v = bf(1:2);
    else
        error('Problem in face ring.');
    end
    j = v(1); k = v(2);
    vi = vertices(i,:);
    vj = vertices(j,:);
    vk = vertices(k,:);
    % angles
    alpha = myangle(vk-vi,vk-vj);
    beta = myangle(vj-vi,vj-vk);
    % add weight
    L(i,j) = L(i,j) + 0.5*cot( alpha );
    L(i,k) = L(i,k) + 0.5*cot( beta );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function beta = myangle(u,v);

du = sqrt( sum(u.^2) );
dv = sqrt( sum(v.^2) );
du = max(du,eps); dv = max(dv,eps);
beta = acos( sum(u.*v) / (du*dv) );