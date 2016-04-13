function IFSObj = loadvrml(VRMLName)

% Locate the VRML parser:
VRML2Matlab = which('VRML2Matlab.exe');
if isempty(VRML2Matlab)
    error('Can''t find VRML parsering application');
end

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

% Check if VRML file exists
if ~exist([FilePath filesep VRMLName],'file')
    FilePath = getenv('ModelsFolder');
    if ~exist([FilePath filesep VRMLName],'file')
        error(['Can''t find ' VRMLName]);
    end
end

% Changing the directory to the model directory (vr problem)
curr_path = pwd;
cd(FilePath);
clear FilePath;

% Parse the VRML file into a matlab files.
[stat,retval] = dos([VRML2Matlab ' ' VRMLName]);
if stat ~= 0
    error(retval);
end;
clear stat retval VRML2Matlab VRMLName

ifscmd = 'IndexedFaceSet(';
X  = [];
T  = {};
N  = [];
C  = [];
TC = [];
TI = [];

% Handle geometry:
fid = fopen(['X.' FileName],'r');
if fid < 0 
    error('Can''t open geometry file.');
end;

% First reading the number of vertices and then the vertices geometry:
nv = fread(fid,1,'uint');
X = fread(fid,3*nv,'float');
X = reshape(X,3,nv)';
ifscmd = [ifscmd 'X '];
fclose(fid);
delete(['X.' FileName]);
clear fid nv 

% Handle Connectivity:
fid = fopen(['T.' FileName],'r');
if fid < 0 
    error('Can''t open connectivity file.');
end;

% First reading the number of items and then the indices:
n = fread(fid,1,'uint32');
M = fread(fid,n,'long');
a = []; f = 0;
for i=1:length(M),
    if M(i) == -1
        f = f + 1;
        T{f} = a+1; % Indices in VRML 0-n-1, in Matlab 1-n
        a = [];
    else
        a = [a M(i)];
    end;
end;
ifscmd = [ifscmd ',T '];
fclose(fid);
delete(['T.' FileName]);
clear fid n M a f i

% Handle normals:
NFN = '';
if exist(['VN.' FileName],'file') 
    ifscmd = [ifscmd ',''vertexnormals'' '];
    NFN = ['VN.' FileName];
end;

if exist(['FN.' FileName],'file') 
    ifscmd = [ifscmd ',''facenormals'' '];
    NFN = ['FN.' FileName];
end;

if ~isempty(NFN)
    fid = fopen(NFN,'r');
	if fid < 0 
        error('Can''t open normals file.');
	end;
    
    % First reading the number of normals and then the normals direction:
    nn = fread(fid,1,'uint');
    N = fread(fid,3*nn,'float');
    N = reshape(N,3,nn)';
    ifscmd = [ifscmd ',N '];
    fclose(fid);
    delete(NFN);    
    clear  fid nn 
end;
clear NFN

% Handle colors:
CFN = '';
if exist(['VC.' FileName],'file') 
    ifscmd = [ifscmd ',''vertexcolors'' '];
    CFN = ['VC.' FileName];
end;

if exist(['FC.' FileName],'file') 
    ifscmd = [ifscmd ',''facecolors'' '];
    CFN = ['FC.' FileName];
end;

if ~isempty(CFN)
    fid = fopen(CFN,'r');
	if fid < 0 
        error('Can''t open colors file.');
	end;
    
    % First reading the number of colors and then the normals direction:
    nc = fread(fid,1,'uint');
    C = fread(fid,3*nc,'float');
    C = reshape(C,3,nc)';
    ifscmd = [ifscmd ',C '];
    fclose(fid);
    delete(CFN);
    clear  fid nc 
end;
clear CFN

% Handle texture-coordinates:
if exist(['TC.' FileName],'file') 
    fid = fopen(['TC.' FileName],'r');
	if fid < 0 
        error('Can''t open texture-coordinates file.');
	end;
    ifscmd = [ifscmd ',''texturecoordinates'' '];
    
    % First reading the number of texture-coordinates and then the normals direction:
    ntc = fread(fid,1,'uint');
    TC = fread(fid,2*ntc,'float');
    TC = reshape(TC,2,ntc)';
    ifscmd = [ifscmd ',TC '];
    fclose(fid);
    delete(['TC.' FileName]);
    clear  fid ntc 
end;

% Handle texture-image:
if exist(['TI.' FileName],'file') 
    fid = fopen(['TI.' FileName],'rt');
	if fid < 0 
        error('Can''t open texture-image file.');
	end;
    ifscmd = [ifscmd ',''textureimage'' '];
    
    [tifn,tifnc] = fscanf(fid,'%s',1);
    fclose(fid);
    delete(['TI.' FileName]);

    if tifnc ~= 1
        error('Can''t read texture image filename.');
    end;
    
    try
        TI = imread(tifn);
    catch
        error(sprintf('Can''t read texure image.\n%s',lasterr));
    end;
    
    ifscmd = [ifscmd ',TI '];
    clear  fid tifn tifnc 
end;

% Returning to the original folder:
cd(curr_path);
clear curr_path

ifscmd = [ifscmd ')'];

try
    IFSObj = eval(ifscmd);
catch
    error(sprintf('Error constructing IndexedFaceSet object.\n%s', lasterr));
end;
