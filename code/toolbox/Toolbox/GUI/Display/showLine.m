function showLine(V,F,fun,vertexStart,vertexEnd,lineColor,lineWidth)
%Display the mesh, with the vertex function. The core code is
%show.dll wrapper by C++. The value of the function is nomalized linearly to [0,1]
%for displaying.
%%Input:
%V--The vertices of the mesh
%F--The facets of the mesh
%fun--The vertex function of the mesh
%vertexStart--The start points of the lines
%vertexEnd--The end points of the line
%lineColor--The color of the lines
%lineWidth--The width of the lines
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
% fun = zeros(size(V,1)) + 0.2;
% vertexStart = V([1,10],:);
% vertexEnd = V([20,60],:);
% lineColor = [1,0,0;0,0,1];
% lineWidth = [1,2];
% showLine(V,F,fun,vertexStart,vertexEnd,lineColor,lineWidth);

%Hui Wang, wanghui19841109@163.com
%Jan. 16, 2010

if nargin < 7
    error('Too less input arguments'); 
elseif nargin == 7
    if max(fun)~= min(fun) 
      fun = 1.0 / (max(fun) - min(fun)) * (fun - min(fun));
    end
    show(V / max(max(V)),F,fun,[],[],[],vertexStart / max(max(V)),vertexEnd / max(max(V)),lineColor,lineWidth,[],[],[]);
end