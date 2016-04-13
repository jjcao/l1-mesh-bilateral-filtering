function [controlA controlb] = compute_control_points(verts,S,nControl)
nVerts = size(S,1);
s = abs(diag(S));
[orderS index] = sort(s,'descend');
controlA = zeros(nControl,nVerts);
controlb = zeros(nControl,3);
for i = 1 : nControl
    controlA(i,index(i)) = 1;
    controlb(i,:) = verts(index(i),:);
end
end