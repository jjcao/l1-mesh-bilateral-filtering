function W = gaussKernal( n1 , n2 , sigma)
% Copyright (c) Li Nannan 2012.10.10
W=exp(-square(norm(n1-n2))/(2*sigma^2));