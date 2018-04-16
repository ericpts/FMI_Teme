function [x, L, U] = DescLU(A, b)
  n = length(A);
  for k = 1 : n
    if det(A(1 : k, 1 : k)) == 0
      error("Matrix has a zero determinant!");
    endif
  endfor
  
  L = zeros(n);
  U = zeros(n);
  x = zeros(n, 1);
  
  for j = 1 : n
    U(1, j) = A(1, j);
  endfor
  
  for i = 1 : n
    L(i, 1) = A(i, 1) / U(1, 1);
  endfor
  
  for k = 2 : n
    for j = k : n
      sum = 0;
      for s = 1 : (k - 1)
        sum += L(k, s) * U(s, j);
      endfor
      U(k, j) = A(k, j) - sum;
    endfor
    
    if U(k, k) == 0
      error("Matrix does not admit LU decomposition");
    endif
    
    for i = k : n
      sum = 0;
      for s = 1 : (k - 1)
        sum += L(i, s) * U(s, k);
      endfor       
      L(i, k) = 1 / U(k, k) * (A(i, k) - sum);
    endfor
  endfor
  
  y = SubsAsc(L, b);
  x = SubsDesc(U, y);
endfunction    