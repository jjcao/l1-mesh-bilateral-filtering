%Generate Gauss noise
%Hui Wang, Nov. 10, 2010

function noise = gaussNoise(m,n,meanValue,varValue)
%Generate a matrix with m rows and n columns, which is from a normal
%distribution of mean meanValue and variance varValue

noise = meanValue + varValue * randn(m,n);