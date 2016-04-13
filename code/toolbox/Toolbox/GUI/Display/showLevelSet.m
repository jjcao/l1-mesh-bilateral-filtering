function showLevelSet(V,F,fun,numOfLevel,width,color)
%Display the mesh, with the vertex function and the level set of the function. The core code is
%show.dll wrapper by C++. 
%%Input:
%V--The vertices of the mesh
%F--The facets of the mesh
%fun--The vertex function of the mesh
%numberOfLevel---The number of the level set
%width---The width of the level set
%color---The color of the level set
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
%showLevelSet(V,F,fun,100,1.0,[0,0,0]);

%Hui Wang, wanghui19841109@gmail.com, Dec. 11, 2011

if nargin < 3
    error('Too less input arguments'); 
elseif nargin == 3
     %fun = 1.0 / (max(fun) - min(fun)) * (fun - min(fun));
     show_LevelSet(V,F,fun,100,1.0,[0,0,0]);
elseif nargin == 4
     %fun = 1.0 / (max(fun) - min(fun)) * (fun - min(fun));
     show_LevelSet(V,F,fun,numOfLevel,1.0,[0,0,0]);
elseif nargin == 5
    %fun = 1.0 / (max(fun) - min(fun)) * (fun - min(fun));
    show_LevelSet(V,F,fun,numOfLevel,width,[0,0,0]);
else
    %fun = 1.0 / (max(fun) - min(fun)) * (fun - min(fun));
    showLevelSet(V,F,fun,numOfLevel,width,color);
end 