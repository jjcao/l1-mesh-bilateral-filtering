function [] = setup_weight_mvc_face(vertices, face,is_cvs)
%   setup_weight_mvc_face - setup mvc weights for vertices in face
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
    L(i,j) = L(i,j)+tan(0.5*gama)/sqrt((vi-vj)*(vi-vj)');
    L(i,k) = L(i,k)+tan(0.5*gama)/sqrt((vi-vk)*(vi-vk)');
end
if(is_cvs(j)==0)
    L(j,i) = L(j,i)+tan(0.5*beta)/sqrt((vi-vj)*(vi-vj)');
    L(j,k) = L(j,k)+tan(0.5*beta)/sqrt((vk-vj)*(vk-vj)');
end
if(is_cvs(k)==0)
    L(k,j) = L(k,j)+tan(0.5*alpha)/sqrt((vk-vj)*(vk-vj)');
    L(k,i) = L(k,i)+tan(0.5*alpha)/sqrt((vi-vk)*(vi-vk)');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function beta = myangle(u,v);

du = sqrt( sum(u.^2) );
dv = sqrt( sum(v.^2) );
du = max(du,eps); dv = max(dv,eps);
beta = acos( sum(u.*v) / (du*dv) );