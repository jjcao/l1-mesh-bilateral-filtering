function [ index, angle, angle_all ] = oriented_normal_nn_search (normal_vec, K)
% NORMAL_NN_SEARCH - compute normal nearest data structure
% 
%   Input:
%         - 'normal_vec'          : (n x 3) array normal of each triangle
%         - 'K'                   : the number of nearest neighbor 
%
%   Output:
%         - 'index'               : a matrix of size R by k which contains the indices of the
%                                   nearest neighbors. Each row of index contains k indices of the
%                                   nearest neighbors to the corresponding query point.
%         - 'distance'            : a matrix of size R by k which contains the distances of
%                                   the nearest neighbors to the corresponding query points, sorted in
%                                   increasing order.
%         - 'angle_all'           : (n x n) contains the angle between every two elements
%
%   Copyright (c) 2012
%%
num = size(normal_vec, 1);
index = zeros(num, K);
angle = zeros(num, K);
angle_all = zeros(num);

for i = 1:num
    angle_vec = zeros(1, num);
    for j = 1:num
        if i ~= j
            n1 = normal_vec(i, :);
            n2 = normal_vec(j, :);
            a = acos(dot(n1, n2));
            angle_vec(j) = a;
            angle_all(i, j) = a;
        end
    end
    [B, IX] = sort(real(angle_vec));
    if IX(1) ~= i
        id = find(IX == i);
        IX(id) = IX(1);
        IX(1) = i;
    end
    angle(i, :) = B(1:K);
    index(i, :) = IX(1:K);
end
end

