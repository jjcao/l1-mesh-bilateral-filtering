function write_mesh(file, vertex, face, normal)

% write_mesh - read data to OFF, PLY, SMF or WRL file.
%
%   write_off(file, vertex, face);
%
%   'vertex' is a 'nb.vert x 3' array specifying the position of the vertices.
%   'face' is a 'nb.face x 3' array specifying the connectivity of the mesh.
%   'normal' is a 'nb.vert x 3' array specifying vertex normals.
%
%   Add normal by jjcao, 2009.
%   Copyright (c) 2005 Gabriel Peyr?

ext = file(end-2:end);
ext = lower(ext);
if strcmp(ext, 'off')
    write_off(file, vertex, face, normal);
elseif strcmp(ext, 'xyz')    
    write_xyz(file, vertex, normal);
elseif strcmp(ext, 'ply')
    write_ply(file, vertex, face);
elseif strcmp(ext, 'smf')
    write_smf(file, vertex, face);
elseif strcmp(ext, 'wrl')
    write_wrl(file, vertex, face);
elseif strcmp(ext, 'obj')
    write_point_obj(file, vertex);
else
    error('Unknown extension.');    
end