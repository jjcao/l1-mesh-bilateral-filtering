function [index Es] = compute_threshold_index(verts,faces,normalsFace,fring,K,omega)
nFaces  = size(normalsFace,1);
Es = zeros(nFaces,1);
for i = 1 : nFaces
    temp = normalsFace(i,:);
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        temp = temp - K(i) * omega(i,neighbors(j)) * normalsFace(neighbors(j),:);
    end
    Es(i) = norm(temp,2);
% Es(i) = var(K(i)*omega(i,:));
end
% threshold = percent * max(Es);
%% index generation
index = [];
% for i = 1 : nFaces
% %     if var(K(i)*omega(i,:)) <= n_threshold
%     if(Es(i) <= threshold)
%         index = [index;i];
%     end
% end

% %% display Es distribution
figure('Name','hist');hist(Es);
% figure('Name','Es_hist');plot(Es,'.');
figure('Name','Feature Es'); set(gcf,'color','white');hold on;
options.face_vertex_color = Es;
h = plot_mesh(verts,faces, options);
camorbit(0,0,'camera');
axis vis3d; 
view(-90, 0);
view3d rot;
set(h, 'edgecolor', 'none'); % cancel display of edge.
colormap jet(256);
%% display feature
% D = ones(nFaces,1);
% D(index) = 0;
% figure('Name','Feature'); set(gcf,'color','white');hold on;
% options.face_vertex_color = D;
% h = plot_mesh(verts,faces,options);
% camorbit(0,0,'camera');
% axis vis3d; 
% view(-90, 0);
% view3d rot;
% set(h, 'edgecolor', 'none'); % cancel display of edge.
% colormap jet(256);
% end