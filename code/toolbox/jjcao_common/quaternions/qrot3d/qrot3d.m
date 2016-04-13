%
% FUNCTION rotdata = qrot3d(data,q)
% FUNCTION rotdata = qrot3d(data,omega,theta)
%
% Author:      Steven Michael
%              smichael@ll.mit.edu
%
% Date:        3/10/2005
%
% Description:
%
% "qrot3d" does a fast quaternion rotation of 3-D data.
% The input is the data and either quaternion directly or 
% a rotation vector and angle from which a quaternion 
% will be constructed.  The function will figure it out 
% based upon the number of inputs.  The output
% is the rotated data.
%
% This is easy enough to do in a MATLAB ".m" file, but it is
% coded it up in C to achieve a very significant speed 
% improvement.
%
% The data must be a 2-D matrix of size (NX3) where N is the 
% number of points. The data can either be single precision or 
% double precision, and must be real.  The output will be in the 
% same format as the input.
%
% For a description of quaternion rotation, see:
% http://mathworld.wolfram.com/Quaternion.html
%