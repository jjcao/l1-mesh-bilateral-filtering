%function NFOF = neighbourFacesOfFace(F, numberOfVertex)
%Compute the neighbour faces of each face
%
%%Input:
%F---the facet of the mesh
%numberOfVertex---the number of the vertex
%
%%Output:
%NFOF---the neighbor faces of each face, which is a cell with dimension
%of numberOfFace * 1
%
%Hui Wang, August 12, 2012, wanghui19841109@gmail.com