function [x, Q, R] = DescQR(A, b)
  n = length(b);
  Q = zeros(n);
  R = zeros(n);
  x = zeros(n, 1);
  
  % STEP 1
  sum = 0;
  for i = 1 : n
    sum += A(i, 1) ^ 2;
  endfor
  R(1, 1) = sum;
  for i = 1 : n
    Q(i, 1) = A(i, 1) / R(1, 1);
  endfor
  for j = 2 : n
    sum = 0;
    for s = 1 : n
      sum += Q(s, 1)* A(s, j);
    endfor
    R(1, j) = sum;
  endfor
  % STEP 2
  
  for k = 2 : n
    suma = 0;
    for i = 1 : n
      suma += A(i, k) ^ 2;
    endfor
    sumr = 0;
    for s = 1 : (k - 1)
      sumr += R(s, k) ^ 2;
    endfor
    R(k, k) = sqrt(suma - sumr);
    
    for i = 1 : n
      sum = 0;
      for s = 1 : (k - 1)
        sum += Q(i, s) * R(s, k);
      endfor
      Q(i, k) = 1 / R(k, k) * (A(i, k) - sum);
    endfor
    for j = k + 1 : n
      sum = 0;
      for s = 1 : n
        sum += Q(s, k) * A(s, j);
      endfor
      R(k, j) = sum;
    endfor
  endfor
  % STEP 3
  
  x = SubsDesc(R, Q' * b);
endfunction

    
    