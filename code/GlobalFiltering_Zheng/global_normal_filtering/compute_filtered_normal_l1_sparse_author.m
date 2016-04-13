function NORMAL = compute_filtered_normal_l1_sparse_author(vertex,face,GT, ORIENTOR, Eps,angle_threshold)
% COMPUTE_FILTERED_NORMAL_L1_SPARSE - compute and filter the normal of the
% triangle set GT via L1 sparse reconstruction (using the code style of Haim Avron)
%
%   Input:
%         - 'vertex'              : (n x 3) array vertex
%         - 'GT'                  : (m x 1) array triangle sets
%        -' ORIENTOR'             : orientor vertor for oritentation normal
%         - 'k'                   : k-nearest neighbor considered
%         -'Eps'                  : determine the noise node
%         - 'angle_threshold'     : used in normal clustering
%
%   Output:
%          - 'point_cluster'      : (m x 1) subneighbor vertex cluster
%
% Reference:
%       (1) - Haim Avron, Andrei Sharf, Chen Greif, and Daniel Cohen-Or. 2010. L1-Sparse reconstruction
%             of sharp point set surfaces. ACM Trans. Graph. 29, 5, Article 135, 12 pages
%
%   Copyright (c) 2012
%% compute triangle normals
num = size(GT, 1);
k = floor(num*0.25);
normal_vec = zeros(num, 3);
for i = 1:num
    tri = GT(i, :);
    e1 = vertex(tri(1), :) - vertex(tri(2), :);
    e2 = vertex(tri(1), :) - vertex(tri(3), :);
    temp = cross(e1, e2);
    % oriente the normals
    if dot(temp,ORIENTOR)<0
        temp = -temp;
    end
    normal_vec(i, :) = temp/norm(temp);  
end
%% construct normal connect graph
% [index, angle, angle_all] = normal_nn_search(normal_vec, k);
% using the unidirectional distance for the oriented normals
[index, angle, angle_all] = oriented_normal_nn_search (normal_vec, k);

connect_graph = zeros(k*num,2);
cont_j = 1;
for i = 1:num
    for j = i+1:num
        if ismember(j, index(i, :)) && ismember(i, index(j, :))
            insect_id = intersect(index(i,:), index(j,:));
            cont = 1;
            % if the normal diverse over the angle threshold, they are not
            % adjacent
            for m = 1:length(insect_id)
                if  angle_all(i,insect_id(m)) <=  angle_threshold && angle_all(j,insect_id(m)) <=  angle_threshold
                    cont = cont + 1;
                end
            end
            cont = cont - 1;
            if cont>=Eps
                connect_graph(cont_j,:) = [i, j];
                cont_j = cont_j + 1;
            end
        end
    end
end
connect_graph(cont_j:end,:) = [];
%% L1 normal reconstruction
% connect graph
E = connect_graph;
% if Isolated normal do followings
temp = unique(E(:,:));
isolate = setdiff(1:num,temp);
E = [E;[isolate' isolate']];
n = num;
epsilon  = 30*pi/180*ones(n,1);

% epsilon = 0.1*ones(n,1);

% edge weight
m = size(E,1);
w = ones(m,1);
ii = [1:m 1:m]';
jj = [E(:, 1); E(:, 2)];
vv = [ones(m, 1); -ones(m, 1)];
D = sparse(ii, jj, vv);

%%
nx0 = normal_vec(:,1);
ny0 = normal_vec(:,2);
nz0 = normal_vec(:,3);

cvx_begin
    variable nx(n);
    variable ny(n);
    variable nz(n);
    minimize( w' * norms(D * [nx ny nz], 2, 2));
    subject to
    norms([nx-nx0 ny-ny0 nz-nz0], 2, 2) <= epsilon;
    cvx_end
% status = cvx_status;
% disp(status);
NORMAL = [nx ny nz];
% normalize the normal
for i = 1:n
    NORMAL(i,:) = NORMAL(i,:)/norm(NORMAL(i,:));
end
NORMAL_INT = NORMAL;
%% Reweighted L1
theta = 15*pi/180;
W = zeros(size(E,1),1);
for j = 1:size(E,1)
    temp = NORMAL(E(j,1),:)*NORMAL(E(j,2),:)';
    temp = temp/(norm(NORMAL(E(j,1),:))*norm(NORMAL(E(j,2),:)));
    temp = acos(temp);
    W(j) = exp(-(temp/theta)^4);
end

% epsilon = 0.05*ones(n,1);
epsilon  = 15*pi/180*ones(n,1);

nx0 = NORMAL(:,1);
ny0 = NORMAL(:,2);
nz0 = NORMAL(:,3);

n = length(nx0);
m = size(D, 1);

cvx_begin
    variable nx(n);
    variable ny(n);
    variable nz(n);
    minimize( W' * norms(D * [nx ny nz], 2, 2))
    subject to
    norms([nx-nx0 ny-ny0 nz-nz0], 2, 2) <= epsilon;
cvx_end
% status = cvx_status;
% disp(status);
NORMAL = [nx ny nz];
% normalize the normal
for i = 1:n
    NORMAL(i,:) = NORMAL(i,:)/norm(NORMAL(i,:));
end
%% show normal results
% figure
% plot_mesh(vertex,face); hold on
% % compute the center vertex of each face
% center_v = zeros(num,3);
% for i = 1:num
%     center_v(i,:) = (vertex(GT(i,1),:)+vertex(GT(i,2),:)+vertex(GT(i,3),:))/3;
% end
% alpha(0.5);
% quiver3(center_v(:,1),center_v(:,2),center_v(:,3),normal_vec(:,1),normal_vec(:,2),normal_vec(:,3),'r');
% hold on
% quiver3(center_v(:,1),center_v(:,2),center_v(:,3),NORMAL(:,1),NORMAL(:,2),NORMAL(:,3),'b');
% hold on
% quiver3(center_v(:,1),center_v(:,2),center_v(:,3),NORMAL_INT(:,1),NORMAL_INT(:,2),NORMAL_INT(:,3),'g');
