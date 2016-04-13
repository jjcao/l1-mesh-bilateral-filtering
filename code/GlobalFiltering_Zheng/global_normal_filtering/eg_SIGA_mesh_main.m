%Input
clear;clc;
path('Toolbox',path);
path('Toolbox\Geometry',path);
path('Toolbox\Numerical_algorithm\Constraint Linear System',path);
close all;
infile = 'three_peaks_v1907.off';
[verts,faces]=read_mesh(infile);

%% ---------------CF-------------------------
Mhe = to_halfedge(verts, faces);
boundary = Mhe.boundary_vertices;
if iscell(boundary)
    boundary=cell2mat(boundary)';
end
if nargin<2
     type = 'angle_defect';
end
% options.type = type;
% options.rings = compute_vertex_face_ring(faces);
% options.boundary = boundary;
% options.show_error = 0;
% phi = compute_conformal_factor(verts, faces, options);   % the comformal factor phi
% minv = min(phi); maxv = max(phi);
% phi = (phi-minv)/(maxv-minv);
% maximaIndex = phi<0.7;                                   %*****************

%% Cgauss = gaussCurvatures(verts, faces);
options.type='normal_cycles';                            % normal_cycles  % angle_defect
[Umin,Umax,Cmin,Cmax,Cmean,Cgauss,Normal] = compute_curvature(verts,faces,options); 
Cgauss = Cmean;
% [maximaIndex,minimaIndex] = extrema(faces, Cgauss, 4, 0.85);
% maximaValue = verts(maximaIndex,:);
% tmp = Cgauss(maximaIndex);
[maximaIndex,minimaIndex] = extrema2(faces, Cmax, Cmin, 4, 0.85);
 maximaValue = verts(maximaIndex,:);
figure('name','extreme value'); set(gcf,'color','white');hold on;axis off; axis equal;
options.alfa=1.0;
h = plot_mesh(verts, faces, options); view3d zoom;colormap jet(256);
hold on;
%maximaIndex = minimaIndex;
h = plot3(verts(maximaIndex,1),verts(maximaIndex,2), verts(maximaIndex,3), 'r.');
set(h, 'MarkerSize', 25);


Laplacian = cotangentLaplacian_noNormalize(verts, faces);
upperEnvelope = ConLinSys_least1(Laplacian,zeros(size(Laplacian,1),3), maximaIndex, maximaValue);
%%
figure('name','embedding'); set(gcf,'color','white');hold on;axis off; axis equal;
normals = compute_vertex_normal(verts,faces);
nn = upperEnvelope-verts;
options = [];
options.alfa=1.0;
options.face_vertex_color = sum((nn).^2,2);
options.face_vertex_color(dot(normals, nn, 2)<0)=0;
h = plot_mesh(verts, faces, options);set(h, 'edgecolor', 'none');  view3d zoom;colormap jet(256);
options=[];
options.alfa=0.4;
hm = plot_mesh(upperEnvelope, faces, options); set(hm, 'edgecolor', 'none');  
