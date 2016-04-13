function meanCurvature = meanCurvatures(V,F)

%Compute mean curvature of each vertex of the mesh surface
%The algorithm is based on the paper "Discrete Differential-Geometry Operators for Triangulated 2-Manifolds"
%Hui Wang, wanghui19841109@gmail.com, Mar. 24, 2010


n = size(V,1);
L = cotangentLaplacian_noNormalize(V,F);
LaplacianCooordinates = L * V;
vertexNormal = vertexNormals(V,F);
mixedArea = VertexCellArea(V,F);

meanCurvature = zeros(n,1);
for i = 1:n
    lengthOfLC = norm(LaplacianCooordinates(i,:));
    meanCurvature(i) = 0.25 / mixedArea(i) * lengthOfLC * sign(dot(LaplacianCooordinates(i,:),vertexNormal(i,:)));
end


