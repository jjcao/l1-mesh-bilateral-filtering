function N = compute_N(vertex,face,normals)
nVerts = size(vertex,1);
nFaces = size(face,1);
N = sparse(nVerts,nVerts);
for s =  1 : nFaces
    for i = 1 : 3
        j = rem(i,3) + 1;
        k = rem(i+1,3) + 1;
        A = [normals(face(s,i),:);0 -normals(face(s,i),3) normals(face(s,i),2);normals(face(s,i),3) 0 -normals(face(s,i),1);-normals(face(s,i),2) normals(face(s,i),1) 0];
        innerP = dot(normals(face(s,i),:),vertex(face(s,i),:));
        bj = cross(normals(face(s,i),:),vertex(face(s,j),:));
        bj = [innerP;bj'];
        bk = cross(normals(face(s,i),:),vertex(face(s,k),:));
        bk = [innerP;bk'];
        projectVj = (A\bj)';
        projectVk = (A\bk)';
        alpha = acos(dot((projectVj-vertex(face(s,i),:)),(projectVk-vertex(face(s,i),:))) / (norm(projectVj-vertex(face(s,i),:)) * (norm(projectVk-vertex(face(s,i),:))))) / 2;
        N(face(s,i),face(s,j)) = N(face(s,i),face(s,j)) + tan(alpha) / norm(projectVj-vertex(face(s,i),:));
        N(face(s,i),face(s,k)) = N(face(s,i),face(s,k)) + tan(alpha) / norm(projectVk-vertex(face(s,i),:));  
    end
end
N = eye(nVerts) - N./repmat(sum(N,2),1,nVerts);
end