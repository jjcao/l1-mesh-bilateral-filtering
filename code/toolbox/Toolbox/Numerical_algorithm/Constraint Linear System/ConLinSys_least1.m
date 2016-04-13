 function X = ConLinSys_least1(A,B,ConIndex,ConValue)
%This is another way to solve constrain(Con) linear(Lin) system(Sys) 
% min||A*X - B||^2 with constraints A(ConIndex,:) = ConValue
%Example
% [V F] = mRead;
% L = tutteGraphLaplacian(F);
% ConIndex = 1:10:size(V,1);
% ConValue = V(ConIndex,:);
% B = zeros(size(V));
% X = ConLinSys_least1(L, B, ConIndex, ConValue);
% mShow(X,F)g

%Hui Wang, Dec 12, 2011, wanghui19841109@gmail.com

%The unknowns index
unIndex = 1:size(A, 2);
unIndex(ConIndex) = 0;
unIndex = find(unIndex > 0);

%Change the matrix B
B = B - A(:, ConIndex) * ConValue;


%Change the matrix A
A = A(:, unIndex);

%The solution
 t = cputime;
unKnowns = (A' * A) \ (A' * B);
disp('The time of the linear system:');
cputime - t
X = zeros(size(B));
X(unIndex,:) = unKnowns;
X(ConIndex,:) = ConValue;