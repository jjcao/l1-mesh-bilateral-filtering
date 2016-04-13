function  sample = farthestVerticesSampling(V,F,N)
%%Sampling the vertices of the triangle mesh by farthest geodestic method, this is according to Alex Bronstein's code 
%Input:  
%V ---the coordinates of the vertices of the triangle mesh
%F ---the fact of the triangle mesh
%N ---the number of the sampling vertices
%Output: sample ---index of the sampling vertices
%%Example:
%[V F] = mRead();
%sample = farthestVerticesSampling(V,F,5);

%Hui Wang, wanghui19841109@gmail.com, First wirtten on April, 29, 2011

n = size(V,1);
sample = round(rand*(n - 1)) + 1; % Initialize with a random point.
d = repmat(Inf, [n 1]);
for k = 1:N - 1,
    % Compute distance map from sample on the shape.
    in = sample(end);
    D =geodesicDistance_dijkstra(V,F,in);
    D =D';
    d = min(d,D);
    [r, idx] = max(d);
    sample = [sample;idx];
    
    %plot (the display of the sampling processing)
%     trisurf(F, V(:,1), V(:,2), V(:,3), d);
%     hold on;
%     h = plot3(V(sample,1), V(sample,2), V(sample,3), 'ok');
%     set(h,'MarkerSize', 5, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [0 0 0]);
%     hold off;
%     axis image; axis off; shading interp; lighting phong; 
%     view([-15 25]);
%     camlight head;    
%     title(sprintf('N = %d   r = %-.2f', k+1, r));
%     drawnow;
end