function ui_write_mesh(vertices,faces)

% ui_write_mesh(vertices,faces)
% description:
%   provide a UI for mesh writing
% input:
%   vertices - mesh vertices
%   faces - mesh faces

currenttime=clock;
defaultname=strcat(num2str(currenttime(1)),'_',num2str(currenttime(2)),'_',...
    num2str(currenttime(3)),'(',num2str(currenttime(4)),'_',...
    num2str(currenttime(5)),'_',num2str(currenttime(6)),')','.off');
[FileName,PathName,FilterIndex] = uiputfile( {'*.off';'*.obj';'*.wrl';'*.*'}, 'Save as',defaultname);
if FilterIndex~=0
    write_mesh([PathName FileName],vertices,faces);
end