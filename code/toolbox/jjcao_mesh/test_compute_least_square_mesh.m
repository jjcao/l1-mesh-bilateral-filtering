% test_compute_least_square_mesh
clear all;
close all hidden;
clc;
%%
% filename = 'data/cube.off'; 
filename = 'data/armadillo_v502.off';
[M.verts,M.faces] = read_mesh(filename);
free_id = [1;2];%[1;2;3;4;5;6];
tag=zeros(length(M.verts),1);tag(free_id)=1;
handle_id = find(tag==0);

%%
s_weights= ones(length(M.verts),1)*1;
c_weights= ones(length(handle_id),1)*10;

clear options;
options.normalize = 0;
options.method = 'soft';%soft or 'hard'
options.type = 'conformal'; % the other choice is 'combinatorial', 'distance', spring, 'conformal', or, 'authalic', mvc, 
L = compute_mesh_laplacian(M.verts,M.faces,'combinatorial',options);%combinatorial;conformal;%spring
delta_coords = L*M.verts;
[newVertices, A] = compute_least_square_mesh(M.verts,M.faces,handle_id,delta_coords,s_weights,c_weights,options);

%% draw deformed mesh
figure;
plot_mesh(newVertices, M.faces);
%shading 'faceted'

%% display free_id
hold on;
h = plot3(M.verts(free_id,1),M.verts(free_id,2), M.verts(free_id,3), 'r.');
set(h, 'MarkerSize', 10);
hold off;