function VV = addNoise(V, F, percent)
%Add Gauss noise to the triangular mesh, the mean of the noise is 0, and
%the variance of the noise is the proportional to the mean edge length

%Hui Wang, Dec. 12, 2011, wanghui19841109@gmail.com

[m, n] = size(V);
meanLength = meanEdgeLength(V, F);

VV = V + gaussNoise(m, n, 0.0, percent * meanLength);