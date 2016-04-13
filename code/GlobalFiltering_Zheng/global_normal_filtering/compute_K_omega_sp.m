function [K,omega] = compute_K_omega_sp(verts,faces,fring,sigmaC,normalsFace)
nFace=size(normalsFace,1);
K=zeros(nFace,1);
omega=sparse(nFace,nFace);
W = duaGraWeiAdjMarFromFile(verts, faces,0.1,0.2);
for i=1:nFace
    Neighbor=fring{i};
    nNeighbor=length(Neighbor);
    Dist=graphshortestpath(W,i);     
    for j=1:nNeighbor
        dist=Dist(Neighbor(j)); % geodesic distance
        omega(i,Neighbor(j)) = exp((-dist)^2 / (2*sigmaC^2));
        K(i)=K(i)+omega(i,Neighbor(j));
    end
    K(i)=1/K(i);
end


