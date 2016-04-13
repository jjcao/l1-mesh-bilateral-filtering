function filteredVerts = compute_vertex_updating_Sun(verts,faces,normalsFace,iteration_vertexUpdating)
nVerts = size(verts,1);
nFaces = size(faces,1);
count = zeros(nVerts,1);
vring = compute_vertex_ring(faces);
verts_Current = verts;
for ite = 1 : iteration_vertexUpdating
    filteredVertsDelta = zeros(nVerts,3);
    for s = 1: nFaces
        for i = 1: 3
            j = rem(i,3) + 1;
            k = rem(i+1,3) + 1;
            Xij = verts_Current(faces(s,j),:) - verts_Current(faces(s,i),:);
            Xik = verts_Current(faces(s,k),:) - verts_Current(faces(s,i),:); 
            filteredVertsDelta(faces(s,i),:) = filteredVertsDelta(faces(s,i),:) + normalsFace(s,:) * dot(normalsFace(s,:),Xij + Xik);
        end
    end
    for i = 1 : nVerts
        count(i) = length(vring{i});
    end
    filteredVertsDelta = filteredVertsDelta ./ repmat(3 * count,1,3);
    filteredVerts = verts_Current + filteredVertsDelta;
    verts_Current = filteredVerts;
end
end