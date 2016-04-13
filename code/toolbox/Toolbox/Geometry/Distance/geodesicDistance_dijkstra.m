function D = geodesicDistance_dijkstra(V,F,point_list)

%%Construct the geodesic distance from vertex point_list (a vector of index of vertex), the geodesic distance is
%approximated by the shortest distance on the mesh graph
%Input:  
%V ---the coordinates of the vertices of the triangle mesh
%F ---the fact of the triangle mesh
%point_list ---the index of the vertex
%Output: d ---the geodesic distance from the vertex i, d(i,j) is
%the geodesic distance between vertex point_list(i) and vertex j
%%Example:
%[V F] = mRead();
%d = geodesicDistance_dijkstra(V,F,1:5);

%Hui Wang, wanghui19841109@gmail.com, First wirtten on Nov. 7, 2010,
%amended on April, 2011


[I,J,W] = distanceMatrix(V,F);
graphDistanceMatrix = sparse(I,J,W);


D = perform_dijkstra_fast(graphDistanceMatrix, point_list); %This dll is copyed forn Gabriel Peyr's code.