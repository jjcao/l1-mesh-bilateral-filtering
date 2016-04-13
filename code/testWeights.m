%% import the related functions
clear;clc;close all;
addpath(genpath(pwd));
%% load the mesh
mesh_file             = {'cube_1538.off','octahedron_1026.off','pyramid_3455.off','fandisk_6475.off', ...
    'octaflower_7919.off','skull_10k.off','head_10k.off','bunny_iH_10k.off'};
mesh_file_noise_small = {'cube_1538_1538_0.1.off','octahedron_1026_1026_0.1.off','pyramid_3455_3455_0.1.off','fandisk_6475_6475_0.1.off', ...
    'octaflower_7919_7919_0.1.off','skull_10k_10002_0.1.off','head_10k_10472_0.1.off','bunny_iH_10k_10937_0.1.off'};
mesh_file_noise_large = {'cube_1538_1538_0.2.off','octahedron_1026_1026_0.2.off','pyramid_3455_3455_0.2.off','fandisk_6475_6475_0.2.off', ...
    'octaflower_7919_7919_0.2.off','skull_10k_10002_0.2.off','head_10k_10472_0.2.off','bunny_iH_10k_10937_0.2.off'};
% 1 = 'cube_1538.off',
% 2 = 'octahedron_1026.off',
% 3 = 'pyramid_3455.off',
% 4 = 'fandisk_6475.off',
% 5 = 'octaflower_7919.off',
% 6 = 'skull_20k.off',
% 7 = 'head_30k.off',
% 8 = 'bunny_iH_35k.off'

% mesh_file = {'30.off','36.off','160.off','180.off','199.off', ...
%     '221.off','303.off','314.off','315.off','326.off', ...
%     '328.off','332.off','353.off','357.off','358.off', ...
%     '379.off','382.off','393.off'};
% mesh_file_noise_small = {'30_15006_0.1.off','36_9076_0.1.off','160_10082_0.1.off','180_9548_0.1.off','199_8647_0.1.off', ...
%     '221_7121_0.1.off','303_15516_0.1.off','314_26437_0.1.off','315_25768_0.1.off','326_14995_0.1.off', ...
%     '328_14994_0.1.off','332_14997_0.1.off','353_1512_0.1.off','357_14872_0.1.off','358_14127_0.1.off', ...
%     '379_6923_0.1.off','382_8078_0.1.off','393_9757_0.1.off'};
% mesh_file_noise_large = {'30_15006_0.2.off','36_9076_0.2.off','160_10082_0.2.off','180_9548_0.2.off','199_8647_0.2.off', ...
%     '221_7121_0.2.off','303_15516_0.2.off','314_26437_0.2.off','315_25768_0.2.off','326_14995_0.2.off', ...
%     '328_14994_0.2.off','332_14997_0.2.off','353_1512_0.2.off','357_14872_0.2.off','358_14127_0.2.off', ...
%     '379_6923_0.2.off','382_8078_0.2.off','393_9757_0.2.off'};
numMesh = length(mesh_file);

for meshIndex = 1 : numMesh
    for noiseScale = 1 : 2
        %% read groundtruth mesh
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
        %  rect = [0 1 0 1 0 1];
        %  verts_noised = compute_mesh_normalized(verts_noised,rect);             % normalization procedure the scale rectangle, [xmin xmax ymin ymax zmin zmax];
        [normalsVert, normalsFace] = compute_vertex_normal(verts_noised,faces_noised);
        %% compute the related geometrical component
        % the parameters shared by all the methods
        flagRing = 2;                              % the neighborhood style,1 represents the I-neighbor, 2 represents the II-neighbor, the default is the II style
        iteration_vertexUpdating = 50;
        flagFilter = 3;                            % 1 represents the bilateral vertex normal filtering  method [Fleishman,FBV]
                                                   % 2 represents the global bilateral face normal filtering method [Zheng,ZGB]
                                                   % 3 represents our method [L1-Sparse,GSR]
        % the filtering and recnstruction process
        % the parameters of our L1-sparse method
        nLamda_GSR = 10;
%                 lamda_GSR_min = 0.5;
%                 lamda_GSR_max = 0.5;
        lamda_GSR_vector = [0.1,0.3,0.5,1,2,3,4,5,6,7];
%         lamda_GSR_vector = linspace(lamda_GSR_min,lamda_GSR_max,nLamda_GSR);
        MSAE_matrix = zeros(nLamda_GSR,1);
        dot = strfind(infile_noise,'.');
        dot = dot(end);
        for i = 1 : nLamda_GSR
            lamda_GSR = lamda_GSR_vector(i);
            filteredNormalsFace = script_bilateral_normal_filter_global_SR_test(verts_noised,faces_noised,normalsFace,lamda_GSR);
            filteredVerts = compute_vertex_updating_Sun(verts_noised,faces_noised,filteredNormalsFace,iteration_vertexUpdating);
            MSAE = mean(acos(sum(filteredNormalsFace .* normalsFace_groundtruth,2)));
            %             MSAE_matrix(i) = MSAE;
            denoised = strcat(infile_noise(1:dot-1),'_GSR_denoised_',num2str(lamda_GSR),'_',num2str(MSAE),'.off');
            write_off(denoised,filteredVerts,faces_noised);
        end
        %         plot(lamda_GSR_vector,MSAE_matrix);
    end
end