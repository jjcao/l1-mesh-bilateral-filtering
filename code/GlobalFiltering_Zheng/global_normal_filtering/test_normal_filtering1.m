%Input
clear;clc;
path('jjcao_mesh',path);
path('jjcao_mesh\toolbox',path);
close all;
%infile = 'armadillo_v502.off';
infile = 'cube_simply_d.off';
[verts,faces]=read_mesh(infile);

%% compute the related geometrical component
[Mhe, Mifs] = to_halfedge(verts, faces);
boundary = Mhe.boundary_vertices;
if iscell(boundary)
    boundary=cell2mat(boundary)';
end
if nargin<2
     type = 'angle_defect';
end

sigmaC = 1;
sigmaS = 0.3;
lamda  = 0.15;

nVerts = size(verts,1);
nFaces = size(faces,1);
normals = compute_face_normals(verts,faces);
normals = - normals;
centers = compute_face_centers(verts,faces);
[areasFaces areaSum areaAve] = compute_area_faces(verts,faces);
A = areasFaces / areaAve;
fring = compute_face_ring(faces);
sigmaC = compute_sigmaC(fring,centers);
Wc = sparse(computer_Wc(centers,fring,sigmaC));
Ws = sparse(computer_Ws(normals,fring,sigmaS));
K = compute_normalization_factorK(fring,areasFaces,Wc,Ws);
zeta = compute_zeta(areasFaces);
omega = zeta.* Wc .* Ws;
filteredNormals = compute_normals_filtered(normals,fring,A,K,omega,lamda);

% trisurf(faces,verts(:,1),verts(:,2),verts(:,3));
% hold on;
figure;
grid on;
hold on;

plot3(verts(:,1),verts(:,2),verts(:,3),'r.');
 
delta = zeros(nFaces,1);
for i = 1 : nFaces
    plot3(centers(i,1),centers(i,2),centers(i,3),'b.');
    hold on;
    plot3([verts(faces(i,1),1),verts(faces(i,2),1)],[verts(faces(i,1),2),verts(faces(i,2),2)],[verts(faces(i,1),3),verts(faces(i,2),3)],'g-');
    hold on;
    plot3([verts(faces(i,3),1),verts(faces(i,2),1)],[verts(faces(i,3),2),verts(faces(i,2),2)],[verts(faces(i,3),3),verts(faces(i,2),3)],'g-');
    hold on;
    plot3([verts(faces(i,1),1),verts(faces(i,3),1)],[verts(faces(i,1),2),verts(faces(i,3),2)],[verts(faces(i,1),3),verts(faces(i,3),3)],'g-');
    hold on;
    % pause(0.5);
    delta(i) = norm(filteredNormals(i,:) - normals(i,:));
end
quiver3(centers(:,1),centers(:,2),centers(:,3),normals(:,1),normals(:,2),normals(:,3),'r');
hold on;
quiver3(centers(:,1),centers(:,2),centers(:,3),filteredNormals(:,1),filteredNormals(:,2),filteredNormals(:,3),'b');


%% normal filtering
% direct method by CG or GMRES

%normalFliter=gmres(coMatrix,bb);

% % l1 normal filtering


%% vertex position updating
% h = plot_mesh(verts,faces,[]);
% hold on;
% figure;
% quiver3(centers(:,1),centers(:,2),centers(:,3),normals(:,1),normals(:,2),normals(:,3),'r');
% hold on;
% quiver3(centers(:,1),centers(:,2),centers(:,3),filteredNormals(:,1),filteredNormals(:,2),filteredNormals(:,3),'b');
% hold on;
% quiver3(cen_v(:,1),cen_v(:,2),cen_v(:,3),normalFliter(:,1),normalFliter(:,2),normalFliter(:,3),'b');
