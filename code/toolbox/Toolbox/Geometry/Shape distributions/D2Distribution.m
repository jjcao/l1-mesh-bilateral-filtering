function distribution = D2Distribution(V, F, numberOfSample, numberOfHist)
%Compute the D2 shape distribution based on TOG 2002 paper "Shape distributions"
%Example:
%distribution = D2Distribution(V, F, 1024^2, 100);

%Hui Wang, Nov. 24, 2011, wanghui19841109@gmail.com

samplePoints = uniformPointsSamplingC(V, F, 2 * numberOfSample);
sample = samplePoints(1 : numberOfSample, :) - samplePoints((numberOfSample + 1) : end, :);
sampleDistance = sqrt(sum(sample .^ 2, 2));

distribution = hist(sampleDistance, numberOfHist) / numberOfSample;