function [V,C,F] = mReadC()

%Read mesh surface from off file

%Hui wang, wanghui19841109@163.com,Nov, 16, 2011

%Example: [V F] = mRead();


[f, pathname,FilterIndex] = uigetfile({'*.off','*.off Files'},'Pick a file');
file = [pathname,f];

if FilterIndex == 1
  [V, C, F] = ReadOffC(file);
else
    error('The file is null!');
end