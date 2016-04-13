%% import the related functions
clear;clc;
addpath(genpath(pwd));
addpath(genpath('data'));
close all;
%% load the mesh
mesh_file             = {'cube_1538.off','octahedron_1026.off','pyramid_3455.off','fandisk_6475.off', ... 
                         'octaflower_7919.off','skull_10k.off','head_10k.off','bunny_iH_10k.off'};
mesh_file_noise_small = {'cube_1538_1538_0.1.off','octahedron_1026_1026_0.1.off','pyramid_3455_3455_0.1.off','fandisk_6475_6475_0.1.off', ... 
                         'octaflower_7919_7919_0.1.off','skull_10k_10002_0.1.off','head_10k_10472_0.1.off','bunny_iH_10k_10937_0.1.off'};
mesh_file_noise_large = {'cube_1538_1538_0.2.off','octahedron_1026_1026_0.2.off','pyramid_3455_3455_0.2.off','fandisk_6475_6475_0.2.off', ... 
                         'octaflower_7919_7919_0.2.off','skull_10k_10002_0.2.off','head_10k_10472_0.2.off','bunny_iH_10k_10937_0.2.off'};
% 'cube_1538.off',
% 'octahedron_1026.off',
% 'pyramid_3455.off',
% 'fandisk_6475.off',
% 'octaflower_7919.off',
% 'skull_20k.off',
% 'head_30k.off',
% 'bunny_iH_35k.off'

% meshIndex = 5;
% noiseScale = 2;
for meshIndex = 1 : 1
    for noiseScale = 1 : 1
% groundtruth mesh
infile = mesh_file{meshIndex};
[verts_groundtruth, faces_groundtruth] = read_mesh(infile);
[normalsVert_groundtruth, normalsFace_groundtruth] = compute_vertex_normal(verts_groundtruth,faces_groundtruth);
% mesh with noises on it
if (noiseScale == 1)  
    mesh_file_noise = mesh_file_noise_small;
else
    mesh_file_noise = mesh_file_noise_large;
end
infile_noise = mesh_file_noise{meshIndex};
[verts_noised, faces_noised] = read_mesh(infile_noise);
rect = [0 1 0 1 0 1];
verts_noised = compute_mesh_normalized(verts_noised,rect);             % normalization procedure the scale rectangle, [xmin xmax ymin ymax zmin zmax];
[normalsVert, normalsFace] = compute_vertex_normal(verts_noised,faces_noised);
%% compute the related geometrical component
% the parameters shared by all the methods
flagRing = 2;                              % the neighborhood style,1 represents the I-neighbor, 2 represents the II-neighbor, the default is the II style
iteration_vertexUpdating = 50;
flagFilter = 3;                            % 1 represents the bilateral vertex normal filtering  method [Fleishman,FBV]
                                           % 2 represents the global bilateral face normal filtering method [Zheng,ZGB]
                                           % 3 represents our method [L1-Sparse,GSR]
% the filtering and recnstruction process
if (flagFilter == 1)
    % the parameters of the FBV method
    %radisu--The kernel size p in the paper for neighbour points search
    %deta_c--The parameter for distance weight function deta_s--The
    %parameter for the similarity weight function n--The number of the
    %iteration
    radisu_FBV = 10;
    n_FBV = 1;
     
    nDeta_c_FBV = 5;
    nDeta_s_FBV = 5;
    deta_c_FBV_min = 0.01;
    deta_c_FBV_max = 0.02;
    deta_s_FBV_min = 0.01;
    deta_s_FBV_max = 0.02;
    
    deta_c_FBV_vector = linspace(deta_c_FBV_min,deta_c_FBV_max,nDeta_c_FBV);
    deta_s_FBV_vector = linspace(deta_s_FBV_min,deta_s_FBV_max,nDeta_s_FBV);
    MSAE_matrix = zeros(nDeta_s_FBV,nDeta_c_FBV);
    for i = 1 : nDeta_s_FBV
        for j = 1 : nDeta_c_FBV
            deta_s_FBV = deta_s_FBV_vector(i);
            deta_c_FBV = deta_c_FBV_vector(j);
            filteredVerts = BilaterFiltering(verts_noised, faces_noised, radisu_FBV, deta_c_FBV, deta_s_FBV, n_FBV);
            [filteredNormalsVert, filteredNormalsFace] = compute_vertex_normal(filteredVerts,faces_noised);
            MSAE_matrix(i,j) = mean(acos(sum(filteredNormalsFace .* normalsFace_groundtruth,2)));
        end
    end
    surf(deta_c_FBV_vector,deta_s_FBV_vector,MSAE_matrix);
    xlabel('detaC');ylabel('detaS');

%     deta_c_FBV = 0.015;
%     deta_s_FBV = 0.02;
%     filteredVerts = BilaterFiltering(verts_noised, faces_noised, radisu_FBV, deta_c_FBV, deta_s_FBV, n_FBV);
%     [filteredNormalsVert, filteredNormalsFace] = compute_vertex_normal(filteredVerts,faces_noised);

elseif (flagFilter == 2)
    % the parameters of the ZGB method
    nSigmaS_ZGB = 10;
    nLamda_ZGB = 7;
    sigmaS_ZGB_min = 0.1;
    sigmaS_ZGB_max = 1;
    lamda_ZGB_min = 0.01;
    lamda_ZGB_max = 0.1;
    sigmaS_ZGB_vector = linspace(sigmaS_ZGB_min,sigmaS_ZGB_max,nSigmaS_ZGB);
    lamda_ZGB_vector = [1e-1,1e-2,1e-3,1e-4,1e-5,1e-6,1e-7];%linspace(lamda_ZGB_min,lamda_ZGB_max,nLamda_ZGB);
%     MSAE_matrix = zeros(nLamda_ZGB,nSigmaS_ZGB);
    dot = strfind(infile_noise,'.');
    dot = dot(end);
    for i = 1 : nLamda_ZGB
        for j = 1 : nSigmaS_ZGB
            sigmaS_ZGB = sigmaS_ZGB_vector(j);
            lamda_ZGB = lamda_ZGB_vector(i);
            filteredNormalsFace = script_bilateral_normal_filter_global(verts_noised, faces_noised, normalsFace, flagRing, sigmaS_ZGB, lamda_ZGB);
            filteredVerts = compute_vertex_updating_Sun(verts_noised,faces_noised,filteredNormalsFace,iteration_vertexUpdating);
%             MSAE_matrix(i,j) = mean(acos(sum(filteredNormalsFace .* normalsFace_groundtruth,2)));
            MSAE = mean(acos(sum(filteredNormalsFace .* normalsFace_groundtruth,2)));
            denoised = strcat(infile_noise(1:dot-1),'_ZGB_denoised_',num2str(sigmaS_ZGB),'_',num2str(lamda_ZGB),'_',num2str(MSAE),'.off');
            write_off(denoised,filteredVerts,faces_noised);
        end
    end
%     surf(sigmaS_ZGB_vector,lamda_ZGB_vector,MSAE_matrix);
%     xlabel('sigmaS');ylabel('lamda');
%     
%     sigmaS_ZGB = 0.3;
%     lamda_ZGB = 0.0000001;
%     filteredNormalsFace = script_bilateral_normal_filter_global(verts_noised, faces_noised, normalsFace, flagRing, sigmaS_ZGB, lamda_ZGB);
%     filteredVerts = compute_vertex_updating_Sun(verts_noised,faces_noised,filteredNormalsFace,iteration_vertexUpdating);
%     
else
    % the parameters of our L1-sparse method
    nLamda_GSR = 1;
    lamda_GSR_min = 0.2;
    lamda_GSR_max = 0.2;
    lamda_GSR_vector = linspace(lamda_GSR_min,lamda_GSR_max,nLamda_GSR);
    MSAE_matrix = zeros(nLamda_GSR,1);
    dot = strfind(infile_noise,'.');
    dot = dot(end);
    for i = 1 : nLamda_GSR
        lamda_GSR = lamda_GSR_vector(i);
        filteredNormalsFace = script_bilateral_normal_filter_global_SR(verts_noised,faces_noised,normalsFace,lamda_GSR);
        filteredVerts = compute_vertex_updating_Sun(verts_noised,faces_noised,filteredNormalsFace,iteration_vertexUpdating);
        MSAE = mean(acos(sum(filteredNormalsFace .* normalsFace_groundtruth,2)));
        MSAE_matrix(i) = MSAE;
        denoised = strcat(infile_noise(1:dot-1),'_GSR_denoised_',num2str(lamda_GSR),'_',num2str(MSAE),'.off');
        write_off(denoised,filteredVerts,faces_noised);
    end
%     plot(lamda_GSR_vector,MSAE_matrix);
end
    end
end
% the numerical evaluation
% MSAE = mean(acos(sum(filteredNormalsFace .* normalsFace_groundtruth,2)));
% %% save the result
% dot = strfind(infile_noise,'.');
% dot = dot(end);
% if (flagFilter == 1)
%    denoised = strcat(infile_noise(1:dot-1),'_FBV_denoised_',num2str(radisu_FBV),'_',num2str(deta_c_FBV),'_',num2str(deta_s_FBV),'_',num2str(n_FBV),'_',num2str(MSAE),'.off');
% elseif (flagFilter == 2)
%    denoised = strcat(infile_noise(1:dot-1),'_ZGB_denoised_',num2str(sigmaS_ZGB),'_',num2str(lamda_ZGB),'_',num2str(MSAE),'.off');
% else
%    denoised = strcat(infile_noise(1:dot-1),'_GSR_denoised_',num2str(lamda_GSR),'_',num2str(MSAE),'.off');
% end
% write_off(denoised,filteredVerts,faces_noised);