function [phi, error] = compute_conformal_factor(vertices, faces, options)
%
%   Reffer to Characterizing Shape Using Conformal Factors_08_jjcao.pdf
%   and Conformal Flattening by Curvature Prescription and Metric
%   Scaling_08_jjcao.pdf
%
%   Copyright (c) 2009 JJCAO
cs_orig = compute_gaussian_curvature(vertices, faces, options);%Gaussian curvature of original mesh
c_orig = sum(cs_orig);
area_t = compute_area_faces(vertices, faces);%total area;
areas_ring = compute_area_ring_faces(vertices, faces, options.rings);
cs_t = c_orig*areas_ring/(3*area_t); % this may be not precise, barycenter neighbor area is better %todo

%% ////////////////////////////////////////////////////////////////////////
% solve conformal factor phi (L*phi = cs_t - cs_orig)
type = 'Laplace-Beltrami'; % the other choice is 'combinatorial', 'distance', spring, 'Laplace-Beltrami', mvc, 
options.normalize = 0; options.symmetrize = 1;
L = compute_mesh_laplacian(vertices,faces, type,options);
b = cs_t - cs_orig;
%b = abs(cs_t - cs_orig); %有找对称轴的效果
%b = abs(abs(cs_t) - abs(cs_orig));%有找1/4部分的效果
phi = L\b;
%phi = L * phi;


%% compute error 
% compute metric scale, new metric and new curvature, and compare
% conformal factor => metric => new target curvature
if isfield(options, 'show_error')
    show_error = options.show_error;
else
    show_error = 0;
end
if ~show_error
    return;
end
%options.type = 'angle_defect';
options.conformal_factors = phi;
cs_computed = compute_gaussian_curvature(vertices, faces, options);

figure('Name','Difference of Gaussian curvature (target - computed)');%hold on;
error = abs(cs_t - cs_computed);
error(error==Inf) = 0;
%minv = min(error); maxv = max(error);
%error = (error-minv)/(maxv-minv);

options.face_vertex_color = error;
h = plot_mesh(vertices, faces, options);
set(h, 'edgecolor', 'none');
colormap jet(256);