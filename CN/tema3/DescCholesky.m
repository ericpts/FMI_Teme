function [x, L] = DescCholesky(A, b)
  if A(1, 1) <= 0
    error("A nu este pozitiv definita!");
  endif
  
  n = length(b);
  L = zeros(n);
  
  % STEP 1
  L(1, 1) = sqrt(A(1, 1));
  for i = 2 : n
    L(i, 1) = A(i, 1) / L(1, 1);
  endfor
  
  % STEP 2
  for k = 2 : n
    sum = 0;
    for s = 1 : (k - 1)
      sum += L(k, s) ^ 2;
    endfor
    alpha = A(k, k) - sum;
    if alpha <= 0
      error("A nu este pozitiv definita!");
    endif
    L(k, k) = sqrt(alpha);
    for i = (k + 1) : n
      sum = 0;
      for s = 1 : (k - 1)
        sum += L(i, s) * L(k, s);
      endfor
      L(i, k) = 1 / L(k, k) * (A(i, k) - sum);
    endfor
  endfor
  
  % STEP 3
  y = SubsAsc(L, b);
  % STEP 4
  x = SubsDesc(L', y);
endfunction
 
  