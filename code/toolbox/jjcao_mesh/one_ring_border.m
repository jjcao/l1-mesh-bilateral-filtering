function [borderV, borderE, borderF] = one_ring_border(vertex_index, Mhe, Mifs)
% get border of 1-ring of a vertex
% borderV: vertex index array.
% borderE: edge index array.
% borderF: face index array.
%%
borderF0 = Mhe.edge_face( Mhe.vertex_orig_edges(vertex_index));
borderF = borderF0( find(borderF0<=Mifs.nof) );  

borderE = zeros(size(borderF));
borderV = zeros(size(borderF));

isBorderV = size(borderF0,2)-size(borderF,2);

for i = 1:size(borderF,2)
    edges = Mhe.face_edges(borderF(i));
    for j = 1:size(edges,2)
        edge = edges(j);
        if Mhe.edge_dest(edge) ~= vertex_index && Mhe.edge_orig(edge) ~= vertex_index
            break;
        end
    end
    
    borderE(i) = edge;
    borderV(i) = Mhe.edge_dest(edge);
end

if isBorderV
    borderV = [Mhe.edge_orig(borderE(1)) borderV];
end