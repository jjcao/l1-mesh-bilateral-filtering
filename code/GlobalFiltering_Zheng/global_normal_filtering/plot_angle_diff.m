function h=plot_angle_diff(verts,faces,angle_diff)

 set(gcf,'color','white');hold on;
% options.face_vertex_color = M.verts(:,3);
options.face_vertex_color = angle_diff;
h = plot_mesh(verts,faces, options);
camorbit(0,0,'camera'); axis vis3d; view(-90, 0);view3d rot;
set(h, 'edgecolor', 'none'); % cancel display of edge.
colormap jet(256);
% colorbar('off');