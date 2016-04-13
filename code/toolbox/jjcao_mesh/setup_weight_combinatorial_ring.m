function []=setup_weight_combinatorial_ring(i,vertices,faces,ring)
%   setup_weight_combinatorial_ring - setup combinatorial weights for vertex i
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
    j = v(1); k=v(2);
    L(i,j) = 1;
    L(i,k) = 1;
end