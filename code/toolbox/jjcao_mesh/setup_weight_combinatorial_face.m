function [] = setup_weight_combinatorial_face(vertices, face,is_cvs)
%   setup_weight_combinatorial_face - setup combinatorial weights for vertices in
%   face
%
%   Copyright (c) 2008 JJCAO
i=face(1);j=face(2);k=face(3);
global L;
if(is_cvs(i)==0)
    L(i,j) = 1;
    L(i,k) = 1;
end
if(is_cvs(j)==0)
    L(j,i) = 1;
    L(j,k) = 1;
end
if(is_cvs(k)==0)
    L(k,j) = 1;
    L(k,i) = 1;
end