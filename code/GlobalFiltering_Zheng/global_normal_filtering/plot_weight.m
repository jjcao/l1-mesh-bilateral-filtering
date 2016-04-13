function    h=plot_weight(omega,verts,faces,showFace)
figure('Name','weights at the choosen point'); set(gcf,'color','white');hold on;
% options.face_vertex_color = M.verts(:,3);
options.face_vertex_color = (omega(showFace,:))';
h = plot_mesh(verts,faces, options);
camorbit(0,0,'camera'); axis vis3d; view(-90, 0);view3d rot;
set(h, 'edgecolor', 'none'); % cancel display of edge.
colormap jet(256);
% colorbar('off');

[c,v,value]=find(omega(showFace,:));
criteria=[max(value) min(value) max(value)/sum(value) min(value)/sum(value)]
meanWeight=[mean(value) mean(value)/max(value)]
I=find(value>mean(value));
num=length(I)

figure; h=plot(value);