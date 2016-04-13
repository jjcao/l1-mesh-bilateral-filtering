function [verts,faces, normal] = read_point_obj(inputmesh)

% read_point_obj - load a .obj point cloud file.
%
%   [verts,faces] = read_point_obj(inputmesh);
%
% faces  : list of triangle elements
% verts  : node coordinatates
%
%(C) JJCAO
% Update history 2009.10.13

fid=fopen(inputmesh);
fseek(fid, -20, 'eof');
nverts = fscanf(fid,'%f');
verts = zeros(nverts,3);
faces = [];
normal = [];

frewind(fid);
tline = fgetl(fid);
tline = fgetl(fid);
for i = 1:nverts
    fseek(fid, 2, 'cof');
    verts(i,:) = fscanf(fid,'%f %f %f');
    fgetl(fid);    
end

fclose(fid);