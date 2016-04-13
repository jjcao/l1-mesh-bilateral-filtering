function dualAdjaMatrix = dualGraphAdjacencyMatrix()

%Read mesh surface from off file
%Output:
%dualAdjaMatrix--The sparse adjacency matrix of the dual graph of the triangle mesh surface
%Example: 
%dualAdjaMatrix = dualAdjacencyMatrixFromFile();

%Hui wang, wanghui19841109@gmail.com, May, 30, 2010

[f, pathname,FilterIndex] = uigetfile({'*.off','*.off Files'},'Pick a file');
file = [pathname,f];

if FilterIndex == 1
  [I,J] = dualGraphAdjaMatrix(file);
else
    error('The file is null!');
    return;
end

w = zeros(size(I)) + 1;
dualAdjaMatrix = sparse(I,J,w);

clear I;
clear J;
clear w;