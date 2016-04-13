function  sample = uniformPointsSamplingC(V,F,N)
%%Sampling the points of the triangle mesh by rand process according to the 2002 TOG paper "Shape Distributions"  
%Input:  
%V ---the coordinates of the points of the triangle mesh
%F ---the fact of the triangle mesh
%N ---the number of the sampling vertices
%Output: sample ---the vertices of the sampling points
%%Example:
%[V F] = mRead();
%sample = uniformPointsSamplingC(V, F, 5);

%Hui Wang, wanghui19841109@gmail.com, First wirtten on Nov, 23, 2011

area = FacetArea(V, F);
cumArea = cumsum(area);
randNumber = rand(N, 3);

sample = sampling(V, F, cumArea, randNumber);