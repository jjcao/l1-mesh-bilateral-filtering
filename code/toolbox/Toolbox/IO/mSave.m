function mSave (vertex, face)

% Save mesh surface for off file
% Shengfa Wang %-- 09-12-26 \:4e0b\:53483:37 --%
% Example:  SaveOff ('m.off',v,f);

 [FileName,PathName,FilterIndex] = uiputfile( {'*.off';'*.off'}, 'Save as');
 filename = [PathName FileName '.off'];
 

if FilterIndex == 1
  SaveOff(filename,vertex,face);
else
    error('The file is null!');
end

