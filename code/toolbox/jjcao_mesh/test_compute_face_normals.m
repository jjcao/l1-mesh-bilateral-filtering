function test_compute_face_normals
clear all;
close all hidden;
clc;
%%
[vertices,faces] = read_mesh('cube.off');
normals = compute_face_normals(vertices, faces);

%% draw deformed mesh
figure;
plot_mesh(vertices, faces);

%% display face normals
options.subsample_normal = 0.8;
h = plot_face_normal(vertices, faces, normals, options);
