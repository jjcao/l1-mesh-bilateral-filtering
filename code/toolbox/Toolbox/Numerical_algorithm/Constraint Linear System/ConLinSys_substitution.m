function X = ConLinSys_substitution(A,B,ConIndex,ConValue)

%According to SMI 2009 paper "Dynamic harmonic fields for surface processing", there are three ways to solve constrain(Con) linear(Lin) system(Sys) 
% A * X = B, with constraints A(ConIndex,:) = ConValue
%as folloes: elimination, substitution and penalty method
%This the substitution method
%Example
% [V F] = mRead;
% L = tutteGraphLaplacian(F);
% ConIndex = 1:10:size(V,1);
% ConValue = V(ConIndex,:);
% B = zeros(size(V));
% X = ConLinSys_elimination(L,B,ConIndex,ConValue);
% mShow(X,F)

%Hui Wang, Dec 27, 2009, wanghui19841109@gmail.com


%Change the matrix A
A(ConIndex,:) = 0;
d = size(A,2) * (ConIndex - 1)  + ConIndex;
A(d) = 1;

%Change the matix B
B(ConIndex,:) = ConValue;

%Solution
% t = cputime;
X = A\B;
% disp('The time of the linear system:');
% cputime - t