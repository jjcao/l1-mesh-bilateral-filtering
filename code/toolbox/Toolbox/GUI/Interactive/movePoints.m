function [index,newPosition] = movePoints(V,F)

%Pick the vertices, and give them new positions
%Input:
%V---The vertices of the mesh surface
%F---The facets of the mesh surface
%Output:
%index---The picked vertices
%newPosition---The new positions of the picked vertices
%How to do?
%1.pick---'p'+leftButton
%2.newPositions---rightButton

%Hui Wang, Dec 11, 2011, wanghui19841109@gmail.com 

r = max(max(V));
V = (1.0 / r) * V;
movePoint(V,F);
load '_index.txt';
load '_points.txt';

index = unique(X_index);
newPosition = r * X_points;