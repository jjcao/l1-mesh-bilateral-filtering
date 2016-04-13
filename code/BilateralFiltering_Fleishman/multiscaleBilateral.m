function smoothScale = multiscaleBilateral(vertex,facets,scaleRadius)

%Multi-scale Bilater mesh smoothing
%%Input:
%vertex--The coordinates of vertex of the triangular mesh
%facets--The facets of the triangular mesh
%scaleRadius--The scale radius for neighbour search, a vertex in ascending
%order

%%Output:
%smoothScale--A cell for multiscale smoothing results

%Hui Wang, Nov. 1, 2011, wanghui19841109@gmail.com

n = length(scaleRadius);
smoothScale = cell(n,1);
smoothVertex = vertex;

for i = 1:n
    smoothVertex = BilaterFilteriing(smoothVertex, facets, scaleRadius(i), 1);
    smoothScale{i} = smoothVertex; 
end