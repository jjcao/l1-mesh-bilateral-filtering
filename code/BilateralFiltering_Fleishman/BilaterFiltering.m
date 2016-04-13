function vertex_new = BilaterFiltering(vertex, facets, radius, deta_c, deta_s, n)

%Bilater mesh filtering based on SIGGAPH 2003's paper "Bilateral Mesh Denoising"
%%Input:
%vertex--The coordinates of vertex of the triangular mesh
%facets--The facets of the triangular mesh
%radisu--The kernel size p in the paper for neighbour points search
%deta_c--The parameter for distance weight function
%deta_s--The parameter for the similarity weight function
%n--The number of the iteration

%%Output:
%vertex_new--The new vertex position

%%Hui Wang, wanghui19841109@gmail.com, Nov. 1, 2011

vertex_new = vertex;

for i = 1:n
    atria = nn_prepare(vertex_new);
    [count, neighbors] = range_search(vertex_new, atria, vertex_new, radius);
    vertexNormal = vertexNormals(vertex, facets);
    vertex_new = bilateral1(vertex_new, vertexNormal, neighbors(:,1), deta_c, deta_s);
end