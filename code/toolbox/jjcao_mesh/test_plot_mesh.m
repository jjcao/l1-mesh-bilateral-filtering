clear;close all;clc;
path('toolbox',path);
%% load a mesh
test_file = {'data/8_isosceles_righttriangle.off','data/horse_v1987.off','three_peaks_v1907.off'};
M.filename = test_file{1};
[M.verts,M.faces] = read_mesh(M.filename);
M.nverts = size(M.verts,1);
M.edges = compute_edges(M.faces); 

%% display point cloud
figure;set(gcf,'color','white');hold on;
% scatter3(M.verts(:,1),M.verts(:,2), M.verts(:,3),10,'b','filled');
scatter3(M.verts(:,1),M.verts(:,2), M.verts(:,3),10,M.verts(:,2),'filled');
axis off;    axis equal;   set(gcf,'Renderer','OpenGL');
camorbit(0,0,'camera'); axis vis3d; view(-90, 0);view3d rot;colorbar('East');

%% display mesh
figure('Name','Mesh'); set(gcf,'color','white');hold on;
% options.face_vertex_color = M.verts(:,3);
options.face_vertex_color = M.verts;
h = plot_mesh(M.verts, M.faces, options);
camorbit(0,0,'camera'); axis vis3d; view(-90, 0);view3d rot;
set(h, 'edgecolor', 'none'); % cancel display of edge.
%colormap jet(256);
colorbar('off');

%% display bundary vertices
boundary=compute_boundary(M.faces);
scatter3(M.verts(boundary,1),M.verts(boundary,2), M.verts(boundary,3),50,'r','filled');
