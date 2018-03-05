function [x] = GaussFaraPiv(A, b)
  A = [A, b];
  n = size(A, 1);
  for k = 1: n - 1
    p = k;
    while A(p, k) == 0 && p <= n
      p += 1;
    end % while;
    if p == n + 1
      disp('Sistem incomp. sau sist. comp. nedet.');
      break
    end % if;
    
    if p != k
      A([p, k], :) = A([k, p], :);
    end % if;
    
    for l = k + 1 : n
      A(l, :) -= A(l, k) / A(k, k) * A(k, :);
    end % for;
  end % for;
  if A(n, n) == 0
    disp('Sistem incomp. sau sist. comp. nedet.');
  end % if;
  x = SubsDesc(A(1:n, 1:n), A(:, n + 1));
end % function