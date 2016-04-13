function showPlane(V,F,fun,center,normal,color)
%Display the mesh, with the vertex function. The core code is
%show.dll wrapper by C++. The value of the function is nomalized linearly to [0,1]
%for displaying.
%%Input:
%V--The vertices of the mesh
%F--The facets of the mesh
%fun--The vertex function of the mesh
%center--The center of the plane
%normal--The normal of the plane
%color--The color of the plane
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
%V = V / max(max(V));
%fun = zeros(size(V,1)) + 0.2;
%mass = sum(V,1) / size(V,1);
%center = [mass;mass];
%normal = [1,0,0;0,1,0];
%color = [0,1,0;0,0,1];
%showPlane(V,F,fun,center,normal,color);

%Hui Wang, wanghui19841109@163.com
%Jan. 16, 2010

if nargin < 6
    error('Too less input arguments'); 
elseif nargin == 6
    show(V,F,fun,[],[],[],[],[],[],[],center,normal,color);
end