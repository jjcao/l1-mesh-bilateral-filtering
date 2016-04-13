function L = compute_g_laplacian(vertices,faces,extrema)
  A = triangulation2adjacency(faces,vertices);
  D = sum(A,2);
  D = repmat(D,1,size(vertices,1));
  A = A ./ D;
  A1 = eye(size(vertices,1));
  L = A1- A;
  for i=1:length(extrema)
     B = zeros(1,size(vertices,1));
     B(extrema(i)) = 1;
     L(extrema(i),:) = B;
  end