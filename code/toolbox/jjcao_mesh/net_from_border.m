function [net_v, net_f] = net_from_border(nv, nr, options)
% nv: number of border vertices
% nr: number of sections along radius
% options
%
%   Copyright (c) 2008 JJCAO

isNeedCenter = getoptions(options, 'isNeedCenter', 1);
if isNeedCenter
    n_net_v = nr*nv+1;
    net_f = zeros((nr-1)*nv*2+nv,3);
    l = nv;
else
    n_net_v = nr*nv;
    net_f = zeros((nr-1)*nv*2,3);
    l=0;
end
net_v = zeros(n_net_v,3);
theta = 2*pi/nv;

for i = 1:(nr-1)
    for j = 0:(nv-1)
        net_v((i-1)*nv+j+1,1:2)=[i*cos(j*theta), i*sin(j*theta)];
        
        l=l+1;
        net_f(l,:)=[(i-1)*nv+j, i*nv + j, i*nv + mod(j+1,nv)];
        l=l+1;
        net_f(l,:)=[(i-1)*nv+j, i*nv + mod(j+1,nv), (i-1)*nv + mod(j+1,nv)];
    end
end

for j = 0:(nv-1)
    net_v((nr-1)*nv+j+1,1:2)=[nr*cos(j*theta), nr*sin(j*theta)];
end

if isNeedCenter
    for j = 0:(nv-1)
        net_f(j+1,:) = [n_net_v-1, j, mod(j+1,nv)];
    end
end

net_f = net_f + 1;