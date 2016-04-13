function [newVertices, A] = compute_least_square_mesh(vertices,faces,constraint_id,delta_coords,s_weights,c_weights,options)
% compute_least_square_mesh - compute a least square mesh
%
% [newVertices A] =
% compute_least_square_mesh(vertices,faces,handle_id,delta_coords,s_weights,c_weights,options)
%
% options.method can be: 'hard', 'soft', 'bi-harmonic'
% A is the final matrix (Ax=b);
%
% Copyright (c) 2009 JJCAO

method = getoptions(options, 'method', 'bi-harmonic');
if ~isfield(options, 'rings')
    options.rings = compute_vertex_face_ring(faces);
end

if ~isfield(options, 'normalize')
    options.normalize = 0; 
end
if ~isfield(options, 'symmetrize')
    options.symmetrize = 1; 
end

switch lower(method) 
    case {'bi-harmonic'}
        [newVertices A] = compute_lsm_bh(vertices,faces,constraint_id,delta_coords,s_weights,c_weights,options);
    case 'hard'
        [newVertices A] = compute_lsm_hard(vertices,faces,constraint_id,delta_coords,options);
    case {'soft'}
        [newVertices A] = compute_lsm_soft(vertices,faces,constraint_id,delta_coords,s_weights,c_weights,options);
    otherwise
        error('Unknown method.');
end

function [newVertices, A] = compute_lsm_bh(vertices,faces,constraint_id,delta_coords,s_weights,c_weights,options)
% compute_ls_soft - compute a least square mesh according to "Least-squares
% Meshes" by Olga Sorkine and Daniel Cohen-Or, 2004.
%
% A is the final matrix (Ax=b);
%
% Copyright (c) 2009 JJCAO
nverts = length(vertices);
ncvs = length(constraint_id);

% Build matrix ////////////////////////////////////////////////////////////
oldTime=cputime;
type = getoptions(options, 'type', 'dcp');%  'combinatorial', 'distance', spring, 'Laplace-Beltrami', mvc, 
S = sparse(1:nverts,1:nverts,s_weights, nverts, nverts);
L = compute_mesh_laplacian(vertices,faces,type,options);

B = zeros(nverts+ncvs,size(vertices,2));
for coord = 1:size(vertices,2)
    % compute right hand side
    b = S*delta_coords(:,coord);
    b(nverts+1:nverts+ncvs,1)=c_weights.*vertices(constraint_id,coord)';
    B(:,coord) = b;
end
sprintf('Build Laplacian matrix, soft, in %f seconds', cputime - oldTime)

% solve ///////////////////////////////////////////////////////////////////
C = sparse(1:ncvs, constraint_id', c_weights, ncvs,nverts);
A = S*L;
oldTime=cputime;
newVertices = (A'*A + C'*C)\([A;C]'*B);
A = [A;C];
sprintf('solve Laplacian matrix, bi-harmonic, in %f seconds', cputime - oldTime)

function [newVertices, A] = compute_lsm_soft(vertices,faces,constraint_id,delta_coords,s_weights,c_weights,options)
% compute_ls_soft - compute a least square mesh according to "LDynamic Harmonic Fields for Surface Processing" 2009.
%
% A is the final matrix (Ax=b);
%
% Copyright (c) 2009 JJCAO
nverts = length(vertices);
ncvs = length(constraint_id);

% Build matrix ////////////////////////////////////////////////////////////
oldTime=cputime;
type = getoptions(options, 'type', 'dcp');%  'combinatorial', 'distance', spring, 'Laplace-Beltrami', mvc, 
S = sparse(1:nverts,1:nverts,s_weights, nverts, nverts);
L = compute_mesh_laplacian(vertices,faces,type,options);

D = zeros(nverts,1);
D(constraint_id) = c_weights;
P = sparse(1:nverts,1:nverts, D, nverts,nverts);

B = zeros(nverts,size(vertices,2));
for coord = 1:size(vertices,2)
    % compute right hand side
    b = delta_coords(:,coord);
    b(constraint_id)= vertices(constraint_id,coord);  
    B(:,coord) = (S+P)*b;
end
sprintf('Build Laplacian matrix, soft, in %f seconds', cputime - oldTime)

% solve ///////////////////////////////////////////////////////////////////
oldTime=cputime;
A=(S*L+P);
newVertices = A\B;
sprintf('solve Laplacian matrix, soft, in %f seconds', cputime - oldTime)

function [newVertices L] = compute_lsm_hard(vertices,faces,constraint_id,delta_coords,options)
type = getoptions(options, 'type', 'dcp');%  'combinatorial', 'distance', spring, 'Laplace-Beltrami', mvc,

% Build matrix ////////////////////////////////////////////////////////////
oldTime=cputime;
L=compute_mesh_laplacian(vertices,faces,type,options);

B=delta_coords;
n = length(vertices);
B(constraint_id,:) = vertices(constraint_id,:);
L(constraint_id,:) = 0;
L = L + sparse(constraint_id, constraint_id, 1, n, n);
sprintf('Build Laplacian matrix, hard, in %f seconds', cputime - oldTime)

% solve ///////////////////////////////////////////////////////////////////
oldTime=cputime;
newVertices = L\B;
sprintf('solve Laplacian matrix, hard, in %f seconds', cputime - oldTime)
