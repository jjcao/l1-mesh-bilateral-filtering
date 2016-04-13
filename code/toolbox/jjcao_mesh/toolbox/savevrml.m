function VRMLName = savevrml(IFSObj,VRMLName)

% Check IFS validity:
if ~isa(IFSObj,'IndexedFaceSet')
    error('SaveVRML works only on IndexedFaceSet and its derived classes.');
end;

% Handle the file name:
[FilePath,FileName,FileExt] = fileparts(VRMLName);
if isempty(FileExt)
	VRMLName = [FileName '.wrl'];
else
	VRMLName = [FileName FileExt];
end;
if isempty(FilePath)
    FilePath = '.';
end;
clear FileExt

% Checking if the file already exist:
if exist([FilePath filesep VRMLName],'file')
    owq = input(['The file ' VRMLName ' already exist. Overwrite? Yes [No]: '],'s');
    if ~strncmpi('yes',owq,length(owq))
        return;
    end;
end;
clear owq 

% Open the VRML file.
[fid,errmsg] = fopen([FilePath filesep VRMLName],'wt');
if fid == -1
    disp(errmsg);
    return;
end;

% Write the header.
fprintf(fid, '#VRML V2.0 utf8\n');
fprintf(fid, 'Shape {\n');

% Handle appearance 
fprintf(fid, '   appearance Appearance {\n');
if ~texture_image_exist(IFSObj)
    fprintf(fid, '      material Material {\n');
else
    % Write the image file.
    try,
        imwrite(texture_image(IFSObj),[FilePath filesep FileName '.jpg'],'jpeg');
    catch
        fclose(fid);
        delete([FilePath filesep VRMLName]);
        error(lasterr);
    end;        
    fprintf(fid, '      texture ImageTexture {\n');
    fprintf(fid, '          url "%s"\n',[FilePath filesep FileName '.jpg']);
end
fprintf(fid, '      }\n');
fprintf(fid, '   }\n');

fprintf(fid, '   geometry IndexedFaceSet {\n');

% Handle geometry.
fprintf(fid, '      coord DEF nameCoord Coordinate {\n');
fprintf(fid, '         point [\n');
fprintf(fid, '            %g %g %g,\n',vertex_coords(IFSObj)');
fprintf(fid, '         ]\n');
fprintf(fid, '      }\n');

% Handle connectivity
fprintf(fid, '      coordIndex [\n');
for i=1:nof(IFSObj),
    fprintf(fid, '         ');
    fprintf(fid, '%d ',face_vertices(IFSObj,i)-1);
    fprintf(fid, '-1,\n');
end;
fprintf(fid, '      ]\n');

% Handle normals:
if face_normals_exist(IFSObj)
    norm = face_normals(IFSObj);
    fprintf(fid, '      normalPerVertex FALSE\n');
elseif vertex_normals_exist(IFSObj)
    norm = vertex_normals(IFSObj);
    fprintf(fid, '      normalPerVertex TRUE\n');
else
    norm = [];
end;
if ~isempty(norm)
	fprintf(fid, '      normal Normal {\n');
	fprintf(fid, '         vector [\n');
	fprintf(fid, '            %g %g %g,\n',norm');
	fprintf(fid, '         ]\n');
	fprintf(fid, '      }\n');
end;
clear norm

% Handle colors:
if face_colors_exist(IFSObj)
    colors = face_colors(IFSObj);
    fprintf(fid, '      colorPerVertex FALSE\n');
elseif vertex_colors_exist(IFSObj)
    colors = vertex_colors(IFSObj);
    fprintf(fid, '      colorPerVertex TRUE\n');
else
    colors = [];
end;
if ~isempty(colors)
	fprintf(fid, '      color Color {\n');
	fprintf(fid, '         color [\n');
	fprintf(fid, '            %g %g %g,\n',colors(:,1:3)');
	fprintf(fid, '         ]\n');
	fprintf(fid, '      }\n');
end;
clear colors

% Handle texture coordinates:
if texture_coords_exist(IFSObj)
	fprintf(fid, '      texCoord TextureCoordinate {\n');
	fprintf(fid, '         point [\n');
	fprintf(fid, '            %1.20g %1.20g,\n',texture_coords(IFSObj)');
	fprintf(fid, '         ]\n');
	fprintf(fid, '      }\n');
end;

fprintf(fid, '   }\n');
fprintf(fid, '}\n');
fprintf(fid, '\n');

% Handle keyframes (if needed).
if key_frames_exist(IFSObj)
	fprintf(fid, 'DEF nameTs TimeSensor {\n');
	fprintf(fid, '   cycleInterval 50\n');
	fprintf(fid, '   loop TRUE\n');
	fprintf(fid, '}\n');
	fprintf(fid, '\n');
	
	fprintf(fid, 'DEF nameCi CoordinateInterpolator {\n');
	fprintf(fid, '   key [\n');
	
	fprintf(fid, '      %g, ', 0:(1/(nokf(IFSObj)-1)):1);
	fprintf(fid, '\n');
	fprintf(fid, '   ]\n');
	fprintf(fid, '   keyValue [\n');
   
	for f=1:nokf(IFSObj),
		fprintf(fid, '      %g %g %g,\n',(key_frames(IFSObj,f))');
		fprintf(fid, '\n');
	end;
   
 	fprintf(fid, '   ]\n');
	fprintf(fid, '}\n');
	fprintf(fid, '\n');
   
   	fprintf(fid, 'ROUTE nameTs.fraction_changed TO nameCi.set_fraction\n');
	fprintf(fid, 'ROUTE nameCi.value_changed TO nameCoord.point\n');
end;

% Closing the file and ending
fclose(fid);
VRMLName = [FilePath filesep VRMLName];
