%% import the related functions
clear;clc;
addpath(genpath(pwd));
close all;
%% load the mesh
mesh_file = {'pyramid_3455.off','head_30k.off','bunny_iH_35k.off','skull_20k.off'};
meshIndex = 4;
infile = mesh_file{meshIndex};
[verts_original, faces_original] = read_mesh(infile);
[normalsVert_original normalsFace_original] = compute_vertex_normal(verts_original,faces_original);

mesh_file_noised = {'bunny_iH_35k_34834_0.1.off','head_30k_30942_0.1.off','pyramid_3455_3455_0.2.off','skull_20k_20002_0.1.off'};
meshIndex_noised = 4;
infile_noised = mesh_file_noised{meshIndex_noised};
[verts,faces] = read_mesh(infile_noised);

% normalization procedure, the scale rectangle, [xmin xmax ymin ymax zmin zmax];
rect = [0 1 0 1 0 1];
verts = compute_mesh_normalized(verts,rect);

centersFace = compute_face_centers(verts,faces);   
fring = compute_face_vertex_ring(faces);
deta_c = compute_sigmaC(fring,centersFace);
radius = 10;
deta_s = 0.1;
n = 1;
filteredVerts = BilaterFilteriing1(verts, faces, radius, deta_c, deta_s, n);
[normalsVert,normalsFace] = compute_vertex_normal(filteredVerts,faces);
MSAE_BF = mean(acos(sum(normalsFace .* normalsFace_original,2)));
%% save the result
dot = strfind(infile_noised,'.');
dot = dot(end);
denoised_BF = strcat(infile_noised(1:dot-1),'_BF_',num2str(deta_s),'_',num2str(n),'_',num2str(MSAE_BF),'.off');
write_off(denoised_BF,filteredVerts,faces);