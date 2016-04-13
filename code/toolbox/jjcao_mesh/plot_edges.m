function h = plot_edges(edges, vertex, sizee, color)

% plot_edges - plot a list of edges
%
%   h = plot_edges(edges, vertex, sizee, color);
%
%   Copyright (c) 2004 Gabriel Peyr?
%   Changed by JJCAO 2011

if nargin<3
    sizee = 3;
end
if nargin<4
    color = 'b';
end

if size(vertex,1)>size(vertex,2)
    vertex = vertex';
end
if size(edges,1)>size(edges,2)
    edges = edges';
end

x = [ vertex(1,edges(1,:)); vertex(1,edges(2,:)) ];
y = [ vertex(2,edges(1,:)); vertex(2,edges(2,:)) ];
if size(vertex,1)==2
    h = line(x,y, 'LineWidth', sizee, 'Color', color);
elseif size(vertex,1)==3
    z = [ vertex(3,edges(1,:)); vertex(3,edges(2,:)) ];
    h = line(x,y,z, 'LineWidth', sizee, 'Color', color);
else
    error('Works only for 2D and 3D plots');    
end