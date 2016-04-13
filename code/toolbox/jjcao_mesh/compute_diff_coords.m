function delta_coords=compute_diff_coords(vertices,faces,options,sel)
% 
% Copyright (c) 2008 JJCAO

% if exist('sel','var') ==0
%     sel = [1:size(vertices,1)];
% end

nverts = size(vertices,1); % number of vertices
weights = ones(1,nverts);
L = compute_laplacian_matrix(vertices,faces,[],weights, options);
delta_coords = zeros(size(vertices));
for coord = 1:min(size(vertices))
    delta_coords(:,coord)=L*vertices(:,coord);
end