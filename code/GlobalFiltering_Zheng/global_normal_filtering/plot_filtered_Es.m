function h=plot_filtered_Es(verts,faces,normalsFace,fring,K,omega)


nFaces  = size(normalsFace,1);
n = nFaces;
D = sparse(nFaces,nFaces);
Es = zeros(nFaces,1);
for i = 1 : n
    D(i,i) = 1;
    temp = normalsFace(i,:);
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        temp = temp - K(i) * omega(i,neighbors(j)) * normalsFace(neighbors(j),:);
        D(i,neighbors(j)) = - K(i) * omega(i,neighbors(j));
    end
    Es(i) = norm(temp,2);
end

figure('Name','Filtered Feature Es'); set(gcf,'color','white');hold on;
options.face_vertex_color = Es;
h = plot_mesh(verts,faces, options);
camorbit(0,0,'camera');
axis vis3d; 
view(-90, 0);
view3d rot;
set(h, 'edgecolor', 'none'); % cancel display of edge.
colormap jet(256);