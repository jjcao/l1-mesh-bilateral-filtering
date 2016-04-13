function A = compute_laplacian_matrix(vertices,faces,options)

% A = compute_laplacian_matrix(vertices,faces,options)
% description:
%   compute a sparse laplacian matrix A
% input:
%   vertices - mesh vertices
%   faces - mesh faces
%   options - options for computing
%     fields in options:
%       1. options.fill_option - 'ring','face'
%       2. options.laplacian - 'combinatorial','conformal'/'dcp','distance','spring','mvc'
%       3. options.normalize
%       4. options.rings
% output:
%   A - sparse laplacian matrix

fill_option = getoptions(options, 'fill_option', 'ring');
laplacian   = getoptions(options, 'laplacian', 'conformal');
normalize   = getoptions(options, 'normalize', 1);

n = size(vertices,1);
global L;
L = sparse(n,n);
        
switch lower(laplacian)
    case 'combinatorial'
        w_handle = str2func(['setup_weight_combinatorial' '_' fill_option]);
    case 'distance'
        w_handle = str2func(['setup_weight_distance' '_' fill_option]);
    case 'spring'
        w_handle = str2func(['setup_weight_spring' '_' fill_option]);
    case {'dcp','conformal'}
        w_handle = str2func(['setup_weight_conformal' '_' fill_option]);
    case 'mvc'
        w_handle = str2func(['setup_weight_mvc' '_' fill_option]);
    otherwise
        error('Unknown discrete Laplacian weight type.')
end

if strcmp(fill_option,'face')
    nfaces = size(faces,1);
    for i = 1:nfaces
        w_handle(vertices,faces(i,:));
    end 
else
    if isfield(options, 'rings')
        rings = options.rings;
    else
        rings = compute_vertex_face_ring(faces);
    end
    for i = 1:n
           w_handle(i,vertices,faces,rings{i});
    end 
end

if normalize == 1
    L = speye(n) - diag(sum(L,2).^(-1))*L;
else
    L = diag(sum(L,2)) - L;
end

A=L;
clear global L;