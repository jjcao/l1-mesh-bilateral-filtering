function  sample = randVerticesSampling(V,F,N)
%%Sampling the vertices of the triangle mesh by rand process 
%Input:  
%V ---the coordinates of the vertices of the triangle mesh
%F ---the fact of the triangle mesh
%N ---the number of the sampling vertices
%Output: sample ---index of the sampling vertices
%%Example:
%[V F] = mRead();
%sample = randVerticesSampling(V,F,5);

%Hui Wang, wanghui19841109@gmail.com, First wirtten on April, 29, 2011

n = size(V,1);
for k = 1:N,
    sample(k,1) = round(rand*(n - 1)) + 1;
    
    %plot (the display of the sampling processing)
%     d = zeros(n,1) + 0.5;
%     trisurf(F, V(:,1), V(:,2), V(:,3),d);
%     hold on;
%     h = plot3(V(sample,1), V(sample,2), V(sample,3), 'ok');
%     set(h,'MarkerSize', 5, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [0 0 0]);
%     hold off;
%     axis image; axis off; shading interp; lighting phong; 
%     view([-15 25]);
%     camlight head;    
%     title(sprintf('N = %d', k));
%     drawnow;
end