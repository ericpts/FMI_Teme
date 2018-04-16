function [x] = SubsAsc(A, b)
  n = length(b);
  x = zeros(n, 1);
  x(1) = 1 / A(1,1) * b(1);
  for k = 2 : n
    s = 0;
    for j = 1 : (k - 1)
      s += A(k, j) * x(j);
    end %for
    x(k) = 1 / A(k, k) * (b(k) - s);
  end %for
end %function