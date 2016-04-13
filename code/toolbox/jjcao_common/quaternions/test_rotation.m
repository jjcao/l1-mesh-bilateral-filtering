fname = 'test_animation.off';
[M.verts,M.faces] = read_mesh(fname);
M.nverts = size(M.verts,1);
%% display mesh
figure;set(gcf,'color','white');
options.face_vertex_color = M.verts(:,3);
h = plot_mesh(M.verts, M.faces, options);
camorbit(0,0,'camera'); axis vis3d; view(-90, 0);view3d rot;
colormap jet(256);
%% transform mesh