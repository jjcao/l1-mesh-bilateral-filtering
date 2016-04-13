Es=zeros(nFaces,1);
for i=1:nFaces
    nn=zeros(1,3);
    neighbors = fring{i};
    nNeighbors = length(neighbors);
    for j = 1 : nNeighbors
        nn=nn+omega(i,j)*sparse_filteredNormals(j);
    end
    nn=sparse_filteredNormals(i)-K(i)*nn;
    Es(i)=A(i)*norms(nn);
end


% M = max(Es);
% m = min(Es);
% for miu = M : -0.3 : m
%     a = find(Es>=miu);
% for i = 1 : length(a)
%     plot3(centers(a(i),1),centers(a(i),2),centers(a(i),3),'k*');
%     hold on;
% end
% pause(2);
% end
% figure;hold on;axis off; axis equal;
% hist(Es); 
% a=find(Es>=1);
% plot3(centers(a,1),centers(a,2),centers(a,3),'mp');view3d zoom;
