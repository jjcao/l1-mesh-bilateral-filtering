function smoothScale = multiscaleBilateral1(vertex, facets, scaleRadius, scaleDeta_c, scale_Deta_s)

%Multi-scale Bilater mesh smoothing
%%Input:
%vertex--The coordinates of vertex of the triangular mesh
%facets--The facets of the triangular mesh
%scaleRadius--The scale radius for neighbour search, a vertex in ascending
%order
%scaleDeta_c--The scale parameter deta_c
%scaleDeta_s--The scale parameter deta_s

%%Output:
%smoothScale--A cell for multiscale smoothing results

%Hui Wang, Nov. 2, 2011, wanghui19841109@gmail.com

n = length(scaleRadius);
smoothScale = cell(n,1);
smoothVertex = vertex;

for i = 1:n
    smoothVertex = BilaterFilteriing1(smoothVertex, facets, scaleRadius(i), scaleDeta_c(i), scale_Deta_s(i), 1);
    smoothScale{i} = smoothVertex; 
end