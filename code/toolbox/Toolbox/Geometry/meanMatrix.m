function M = meanMatrix(F,k)

%%Construct the matrix for compute the mean of a function at k-ring
%Input:  F ---the fact of the mesh
%        k ---the number of ring, uaually 1 or 2
%Output: M ---the mean matrix of k-ring
%%Example:
%[V F] = mRead();
%M = meanMatrix(F,k)

%Hui Wang, wanghui19841109@gmail.com, Dec. 11, 2011

W = graphAdjacencyMatrix(F);
n = size(W);
W2 = W^k + speye(n);
W2 = spones(W2);
M = sparse(1:size(W2,1),1:size(W2,1),sum(W2,2).^-1) * W2;