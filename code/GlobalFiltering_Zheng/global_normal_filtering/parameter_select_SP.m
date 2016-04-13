function [sigmaS,lamda,epsilon] = parameter_select_SP(sigmaS_vector,lamda_vector,epsilon_vector,verts,faces,normalsFace,normalsFace_original,flagRing,flagFilter,iteration_normalFiltering)
nSigmaS = length(sigmaS_vector);
nn = length(epsilon_vector);
indexSigmaS = 0;
indexN = 0;

min = inf;
M=zeros(nSigmaS,nn);
lamda=lamda_vector(1);

for i = 1 : nSigmaS
    for j = 1 : nn
         filteredNormalsFace = compute_filtered_normals_global(verts,faces,normalsFace,flagRing,flagFilter,sigmaS_vector(i),lamda,epsilon_vector(j),iteration_normalFiltering);
         MSAE = mean(acos(sum(filteredNormalsFace .* normalsFace_original,2)));
         M(i,j)=MSAE;
         if(MSAE < min)
             min = MSAE;
             indexSigmaS = i;
             indexN = j;
         end
    end
end
figure('Name','MSAE');h=mesh(sigmaS_vector,epsilon_vector,M');
xlabel('sigma'),ylabel('epsilon'),zlabel('MSAE');
sigmaS = sigmaS_vector(indexSigmaS);
epsilon = epsilon_vector(indexN);

end