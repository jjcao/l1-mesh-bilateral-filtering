function  sample = uniformPointsSampling(V,F,N)
%%Sampling the points of the triangle mesh by rand process according to the 2002 TOG paper "Shape Distributions"  
%Input:  
%V ---the coordinates of the points of the triangle mesh
%F ---the fact of the triangle mesh
%N ---the number of the sampling vertices
%Output: sample ---the vertices of the sampling points
%%Example:
%[V F] = mRead();
%sample = uniformPointsSampling(V,F,5);

%Hui Wang, wanghui19841109@gmail.com, First wirtten on April, 29, 2011

area = FacetArea(V,F);
cumArea = cumsum(area);
for k = 1:N
    randNum = rand * cumArea(end);
    z = abs(cumArea - randNum);
    [r,indexOfFacet] = min(z);
    
    P1 = V(F(indexOfFacet,1),:);
    P2 = V(F(indexOfFacet,2),:);
    P3 = V(F(indexOfFacet,3),:);
    r1 = rand;
    r2 = rand;
    sample(k,:) = (1.0 - sqrt(r1)) * P1 + sqrt(r1) * (1.0 - r2) * P2 + sqrt(r1) * r2 * P3;
    
%     plot (the display of the sampling processing)
    d = zeros(size(V,1),1) + rand;
    trisurf(F, V(:,1), V(:,2), V(:,3), d);
    hold on;
    h = plot3(sample(:,1), sample(:,2),sample(:,3), 'ok');
    set(h,'MarkerSize', 5, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [0 0 0]);
    hold off;
    axis image; axis off; shading interp; lighting phong; 
    view([-15 25]);
    camlight head;    
    title(sprintf('N = %d', k));
    drawnow;
end