%Compute the first k small eigenvalues and the coorresponding eigenvectors
%of the triangular mesh


%Hui Wang, Dec. 12, 2011, wanghui19841109@gmail.com

function [eigvector,eigvalue,mixedArea] = eigenDecoLaplacian(V, F, k)

W = cotangentLaplacian_noNormalize(V, F);

mixedArea = VertexCellArea(V, F);
A = sparse(1:length(mixedArea), 1:length(mixedArea), mixedArea');
 
[eigvector, eigvalue] = eigs(W, A, k, 'sm');
eigvalue = diag(eigvalue);

%The increasing order
[eigvalue, index] = sort(eigvalue);
eigvector = eigvector(:, index);