function X = ConLinSys_elimination(A,B,ConIndex,ConValue)
%According to SMI 2009 paper "Dynamic harmonic fields for surface processing", there are three ways to solve constrain(Con) linear(Lin) system(Sys) 
% A * X = B, with constraints A(ConIndex,:) = ConValue
%as folloes: elimination, substitution and penalty method
%This the elimination method
%Example
% [V F] = mRead;
% L = tutteGraphLaplacian(F);
% ConIndex = 1:10:size(V,1);
% ConValue = V(ConIndex,:);
% B = zeros(size(V));
% X = ConLinSys_elimination(L,B,ConIndex,ConValue);
% mShow(X,F)

%Hui Wang, Dec 27, 2009, wanghui19841109@gmail.com

%The unknowns index
unIndex = 1:size(A,2);
unIndex(ConIndex) = 0;
unIndex = find(unIndex > 0);

%Change the matrix B
B = B - A(:,ConIndex) * ConValue;
B = B(unIndex,:);

%Change the matrix A
A = A(unIndex,unIndex);

%The solution
% t = cputime;
unKnowns = A \ B;
% disp('The time of the linear system:');
% cputime - t
X = zeros(size(B));
X(unIndex,:) = unKnowns;
X(ConIndex,:) = ConValue;
