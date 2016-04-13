%Compute the diffusion distance from i-th vertex with t time
%Hui Wang
%March 19, 2011

function d = diffusionDistance(eigvector,eigvalue,i,t)

eigvector = eigvector(:,2:end);
eigvalue = eigvalue(2:end);

n = size(eigvector,1);
matrix = -1.0 * speye(n);
matrix(:,i) = 1.0;
matrix(i,:) = 0.0;

M = matrix * eigvector;
M = M .^ 2;

eigvalue = exp(-2.0 * t *eigvalue);
d = M * eigvalue;