function [] = setup_weight_conformal_face(vertices, face,is_cvs)
%   setup_weight_conformal_face - setup conformal weights for vertices in
%   face
%
%   Copyright (c) 2008 JJCAO
i=face(1);j=face(2);k=face(3);
vi=vertices(i,:);vj=vertices(j,:);vk=vertices(k,:);
% angles
alpha = myangle(vk-vi,vk-vj);%ij
beta = myangle(vj-vi,vj-vk);%ik
gama = myangle(vi-vj,vi-vk);%jk %pi-alpha-beta;
global L;
if(is_cvs(i)==0)
    L(i,j) = L(i,j)+0.5*cot( alpha );
    L(i,k) = L(i,k)+0.5*cot( beta );
end
if(is_cvs(j)==0)
    L(j,i) = L(j,i)+0.5*cot( alpha );
    L(j,k) = L(j,k)+0.5*cot( gama );
end
if(is_cvs(k)==0)
    L(k,j) = L(k,j)+0.5*cot( gama );
    L(k,i) = L(k,i)+0.5*cot( beta );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function beta = myangle(u,v);

du = sqrt( sum(u.^2) );
dv = sqrt( sum(v.^2) );
du = max(du,eps); dv = max(dv,eps);
beta = acos( sum(u.*v) / (du*dv) );