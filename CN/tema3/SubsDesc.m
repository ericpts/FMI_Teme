function [x] = SubsDesc(A, b)
  n = length(b);
  x = zeros(n, 1);
  x(n) = 1 / A(n, n) * b(n);
  for k = (n - 1) : -1 : 1
    s = 0;
    for i = (k + 1) : n
      s += A(k, i) * x(i);
    endfor
    x(k) = 1 / A(k, k) * (b(k) - s);
  endfor
end %function