function mSaveC(vertex, color, face)

% Save mesh surface for off file with vertex color
% Hui Wang, Nov. 16, 2011

 [FileName,PathName,FilterIndex] = uiputfile( {'*.off';'*.off'}, 'Save as');
 filename = [PathName FileName '.off'];
 

if FilterIndex == 1
  SaveOffC(filename, vertex, color, face);
else
    error('The file is null!');
end
