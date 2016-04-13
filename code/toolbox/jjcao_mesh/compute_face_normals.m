function normals = compute_face_normals(vertices, faces, bNormalized)
% unit normals to the faces
%
% JJCAO 2009
normals = crossp( vertices(faces(:,2),:)-vertices(faces(:,1),:), ...
                  vertices(faces(:,3),:)-vertices(faces(:,1),:) );
if nargin < 3
    bNormalized = 1;
end
if bNormalized
    d = sqrt( sum(normals.^2,2) ); d(d<eps)=1;
    normals = normals ./ repmat( d, 1,3 );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = crossp(x,y)
% x and y are (m,3) dimensional
z = x;
z(:,1) = x(:,2).*y(:,3) - x(:,3).*y(:,2);
z(:,2) = x(:,3).*y(:,1) - x(:,1).*y(:,3);
z(:,3) = x(:,1).*y(:,2) - x(:,2).*y(:,1);