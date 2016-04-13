function [cycles]=findcycles(G)
numNodes = size(G,1); 
cycles = cell(0);
for n = 1:numNodes
   [D,P]=graphtraverse(G,n);
   for d = D
       if G(d,n)
           cycles{end+1} = graphpred2path(P,d);
       end
   end
   G(n,:)=0; 
end
