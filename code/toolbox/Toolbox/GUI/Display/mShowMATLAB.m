function mShowMATLAB(V,F,D)

%Display the triangular mesh by the MATLAB
%%Input:
%V--The vertices of the mesh
%F--The facets of the mesh
%D--The scalar defined on  the mesh
%%Example:
%[V,F] = mRead;
%mShow(V,F,V(:,1));
%Hui Wang, wanghui19841109@gmail.com, Dec. 11, 2011   

if nargin < 2
  error('Enough input!');
elseif nargin == 2
  trisurf(F,V(:,1),V(:,2),V(:,3));
elseif nargin == 3
  trisurf(F,V(:,1),V(:,2),V(:,3),D);
else
  error('Two much input!');
end
    
 axis image; axis off; shading interp; lighting phong; 
 view([-10 15]); 
%  camlight head; 
 colormap Cool;
 title(sprintf('The mesh'));
 drawnow;