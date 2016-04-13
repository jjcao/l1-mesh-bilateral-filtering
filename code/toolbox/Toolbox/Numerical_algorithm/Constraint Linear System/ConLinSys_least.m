function X = ConLinSys_least(A,B,ConIndex,ConValue,s)
%According to SMI 2009 paper "Dynamic harmonic fields for surface processing", there are three ways to solve constrain(Con) linear(Lin) system(Sys) 
% min(||A*X - B||^2 + \sum_{j = 1}^{m}||s(j) * (X(ConIndex(j),:) - ConValue(j,:))||^2)
%as folloes: elimination, substitution and penalty method
%This the penty method
%Example
% [V F] = mRead;
% L = tutteGraphLaplacian(F);
% ConIndex = 1:10:size(V,1);
% ConValue = V(ConIndex,:);
% B = zeros(size(V));
% X = ConLinSys_least(L, B, ConIndex, ConValue, 0 * ConValue + 1.0);
% mShow(X,F)

%Hui Wang, Dec 12, 2011, wanghui19841109@gmail.com


%Left matrix of linear least sysytem
n = size(A, 2);
w = zeros(n, 1);
w(ConIndex) = s;
W = sparse(1:length(w), 1:length(w), w');
W = W(ConIndex, :);
A = [A; W];

%Right matrix of linear least sysytem
m = length(s);
W1 = sparse(1:m, 1:m, s);
B = [B; W1 * ConValue];
X = (A' * A) \ (A' * B);
