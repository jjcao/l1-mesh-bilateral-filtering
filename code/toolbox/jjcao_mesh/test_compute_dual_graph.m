clear;close all;clc;
path('toolbox',path);
%% load a mesh
test_file = {'data/8_isosceles_righttriangle.off','data/horse_v1987.off','catHead_v131.off'};
M.filename = test_file{3};
[M.verts,M.faces] = read_mesh(M.filename);
M.nverts = size(M.verts,1);
M.edges = compute_edges(M.faces); 

%% display mesh
figure('Name','Mesh'); set(gcf,'color','white');hold on;
% options.face_vertex_color = M.verts(:,3);
options.face_vertex_color = M.verts;
h = plot_mesh(M.verts, M.faces, options);
camorbit(0,0,'camera'); axis vis3d; view(-90, 0);view3d rot;colorbar('off');

%% display dual mesh
[A,vertex1] = compute_dual_graph(M.faces,M.verts);
figure('Name','Dual Mesh'); set(gcf,'color','white');hold on;
h = plot_graph(A,vertex1, options);
axis off;    axis equal; 
camorbit(0,0,'camera'); axis vis3d; view(-90, 0);view3d rot;
