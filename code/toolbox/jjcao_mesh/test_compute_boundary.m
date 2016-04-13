function test_compute_boundary(file)

[vertices,faces]=read_mesh(file);

%%
boundary=compute_boundary(faces);
figure;
plot_mesh(vertices, faces);
shading 'faceted';
% display starting points
hold on;
ms = 25;
for i=1:length(boundary)
    cv = vertices(boundary(i),:);
    h = plot3( cv(1),cv(2), cv(3), 'r.');
    set(h, 'MarkerSize', ms);    
end
hold off;

%%
[Mhe,Mifs] = to_halfedge(vertices, faces);
boundary = Mhe.boundary_vertices;
if iscell(boundary)
    boundary=cell2mat(boundary)';
end
figure;
plot_mesh(vertices, faces);
shading 'faceted';
% display starting points
hold on;
ms = 25;
for i=1:length(boundary)
    cv = vertices(boundary(i),:);
    h = plot3( cv(1),cv(2), cv(3), 'r.');
    set(h, 'MarkerSize', ms);    
end
hold off;