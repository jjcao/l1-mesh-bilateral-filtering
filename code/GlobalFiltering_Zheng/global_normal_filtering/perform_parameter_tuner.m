function perform_parameter_tuner(sigmaS_par,lamda_par,nthresold_par,vert_original,verts,faces)
% sigmaS_par = [0.18 0.2 5];
% lamda_par = [0.18 0.20 5];
% nthresold_par = [0.5 0.6 5];
% perform_parameter_tuner(sigmaS_par,lamda_par,nthresold_par,vert_original,verts_noised,faces);
nVerts = size(verts,1);
nFaces = size(faces,1);
normal_original=compute_face_normals(vert_original,faces);
normalsFace = compute_face_normals(verts,faces);
centersFace = compute_face_centers(verts,faces);
areasFace = compute_area_faces(verts,faces);
Area = areasFace / mean(areasFace);
fring = compute_face_ring(faces);
sigmaC = compute_sigmaC(fring,centersFace);
Wc = compute_Wc(centersFace,fring,sigmaC);
zeta = compute_zeta(areasFace);

sigmaS_min = sigmaS_par(1);
sigmaS_max = sigmaS_par(2);
sigmaS_count = sigmaS_par(3);

lamda_min = lamda_par(1);
lamda_max = lamda_par(2);
lamda_count = lamda_par(3);

n_thresold_min = nthresold_par(1);
n_thresold_max = nthresold_par(2);
n_thresold_count = nthresold_par(3);

simgaS_vector = linspace(sigmaS_min,sigmaS_max,sigmaS_count);
lamda_vector = linspace(lamda_min,lamda_max,lamda_count);
n_thresold_vector = linspace(n_thresold_min,n_thresold_max,n_thresold_count);

Gap_DM = zeros(sigmaS_count,lamda_count);
Gap_SP = zeros(sigmaS_count,n_thresold_count);
for i = 1 : sigmaS_count
sigmaS = simgaS_vector(i);
Ws = compute_Ws(normalsFace,fring,sigmaS);
K_factor = compute_normalization_factorK(fring,areasFace,Wc,Ws);
omega = zeta.* Wc .* Ws;
%% normal filtering
% direct method by CG or GMRES
for j = 1 : lamda_count
    lamda = lamda_vector(j);
    filteredNormalsFace_DM = compute_normals_filtered(normalsFace,fring,Area,K_factor,omega,lamda);
    Gap_DM(i,j) = sum(sum((filteredNormalsFace_DM - normal_original).^2)) / nFaces;
end
% Sparse normal filtering
for k = 1 : n_thresold_count
n_threshold = n_thresold_vector(k);
cvx_solver SDPT3;
filteredNormalsFace_SP = sparseNF(normalsFace,fring,Area,K_factor,omega,n_threshold);
Gap_SP(i,k) = sum(sum((filteredNormalsFace_SP - normal_original).^2)) / nFaces;
end
end
figure;
grid on;
hold on;
mesh(lamda_vector,simgaS_vector,Gap_DM);
figure;
grid on;
hold on;
mesh(n_thresold_vector,simgaS_vector,Gap_SP);
end