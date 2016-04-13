function showVertex(V,F,fun,position,color,size)
%Display the mesh, with the vertex function. The core code is
%show.dll wrapper by C++. The value of the function is nomalized linearly to [0,1]
%for displaying.
%%Input:
%V--The vertices of the mesh
%F--The facets of the mesh
%fun--The vertex function of the mesh
%position--The position of the vertices
%color--The colors of the vertices
%size--The size of the vertices
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
%fun = zeros(size(V,1),1) + 0.2;
%Position = V(1:10:size(V,1),:);
%Color = zeros(size(Position,1),3);
%Color(:,1) = 1.0;
%Size = zeros(size(Position,1),1) + 1.0;
%showVertex(V,F,fun,Position,Color,Size);

%Hui Wang, wanghui19841109@163.com
%Jan. 16, 2010

if nargin < 6
    error('Too less input arguments'); 
elseif nargin == 6
%     if max(fun)~= min(fun) 
%       fun = 1.0 / (max(fun) - min(fun)) * (fun - min(fun));
%     end
    show(V,F,fun,position,color,size,[],[],[],[],[],[],[]);
end 