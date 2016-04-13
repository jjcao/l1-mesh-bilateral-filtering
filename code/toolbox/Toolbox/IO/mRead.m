function [V,F] = mRead()

%Read mesh surface from off file

%Hui wang, wanghui19841109@163.com,Dec, 25, 2009

%Example: [V F] = mRead();


[f, pathname,FilterIndex] = uigetfile({'*.off','*.off Files'},'Pick a file');
file = [pathname,f];

if FilterIndex == 1
  [V F] = ReadOff(file);
else
    error('The file is null!');
end