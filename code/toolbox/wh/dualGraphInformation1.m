% function [I,J,AD,Concave,ED,Dist] = dualGraphInformation(V, F);
%Compute the informations (face indices, dihedral angles, edge lengths,
%dual edge lengths, and vertices lengths) of the dual graph of the mesh
%based on the CGAL polyhedron class

%Hui Wang, Jan. 13, 2012, wanghui19841109@gmail.com