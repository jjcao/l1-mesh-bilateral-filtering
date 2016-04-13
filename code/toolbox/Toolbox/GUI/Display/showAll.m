function showAll(V,F,fun,pointPosition,pointColor,pointSize,lineStart,lineEnd,lineColor,lineWidth,planeCenter,planeNormal,planeColor)
%Display the mesh, with the vertex function. The core code is
%show.dll wrapper by C++. The value of the function is nomalized linearly to [0,1]
%for displaying.
%%Input:
%V--The vertices of the mesh
%F--The facets of the mesh
%fun--The vertex function of the mesh
%pointPosition--The position of the points
%pointColor--The color of the points
%pointSize--The size of the points
%lineStart--The start points of the lines
%lineEnd--The end points of the lines
%lineColor--The color of the lines
%lineWidth--The width of the lines
%planeCenter--The center of the planes
%planeNormal--The normal of the planes
%planeColor--The color of the planes
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
% [V,F] = mRead;
% V = V / max(max(V));
% fun = zeros(size(V,1),1) + 0.2;
% pointPosition = (V([1,50],:));
% pointColor = [0,0,1;0,0,1];
% pointSize = [0.01;0.01];
% lineStart = V(1,:);
% lineEnd = V(50,:);
% lineColor = [0,1,0];
% lineWidth = [0.5];
% planeCenter = 0.5 * (V(1,:) + V(50,:));
% planeNormal = V(1,:) - V(50,:);
% planeColor = [1,0,0];
% show(V,F,fun,pointPosition,pointColor,pointSize,lineStart,lineEnd,lineColor,lineWidth,planeCenter,planeNormal,planeColor);

%Hui Wang, wanghui19841109@163.com
%Jan. 16, 2010

if nargin < 13
    error('Too less input arguments'); 
elseif nargin == 13
    show(V,F,fun,pointPosition,pointColor,pointSize,lineStart,lineEnd,lineColor,lineWidth,planeCenter,planeNormal,planeColor);
end