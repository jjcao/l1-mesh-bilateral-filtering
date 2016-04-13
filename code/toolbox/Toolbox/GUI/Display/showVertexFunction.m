% function showVertexFunction(V,F,fun)
%Display the mesh, with the vertex function. The core code is
%show.dll wrapper by C++. 
%%Input:
%V--The vertices of the mesh
%F--The facets of the mesh
%fun--The vertex function of the mesh
%%Note:In the render window, you can use the following shortcut key
%"Alt + f" ------The flat interpolation
%"Alt + g"-------The ground interpolation
%"Alt + w"-------The representation is: surface + wireframe
%"Alt + p"-------THe representation is point
%'w'      -------The representation is wireframe
%'s'      -------The representation is surface
%"Alt + l"-------Use light or not
%"Alt + +"-------Enhance the light when the light is used
%"Alt + -"-------Reduce the light when the light is used
%"Alt + b"-------Show back
%%Example:
%[V,F] = mRead;
%showVertexFunction(V,F,V(:,1));

%Hui Wang, wanghui19841109@gmail.com
%Dec. 11, 2011
