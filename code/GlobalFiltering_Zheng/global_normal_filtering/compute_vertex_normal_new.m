function normal = compute_vertex_normal_new(vertex,face,normalf)
nface = size(face,1);
nvert = size(vertex,1);
normal = zeros(nvert,3);
for i=1:nface
    f = face(i,:);
    for j=1:3
        normal(f(j),:) = normal(f(j),:) + normalf(i,:);
    end
end
% normalize
    d = sqrt( sum(normal.^2,2) ); d(d<eps)=1;
    normal = normal ./ repmat( d, 1,3 );
% enforce that the normal are outward
v = vertex - repmat(mean(vertex,2), 1,3);
s = sum( v.*normal, 1 );
if sum(s>0)<sum(s<0)
    % flip
    normal = -normal;
end
end