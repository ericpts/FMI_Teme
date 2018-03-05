function [x] = GaussPivTot(A, b)
  A = [A, b];
  n = size(A, 1);
  xi = 1:n;
  
  for k = 1 : n - 1
    p = k;
    m = k;
    for i = k : n
      for j = k : n
        if abs(A(i, j)) > abs(A(p, m))
          p = i;
          m = j;
        end % if;
      end % for;
    end % for;
    
    if A(p, m) == 0
      disp('Sistem incomp. sau sist. comp. nedet.');
      break;
    end % if;
    
    if p != k
      A([p, k], :) = A([k, p], :);
    end % if;
    
    if m != k
      A(:, [m, k]) = A(:, [k, m]);
      xi([m, k]) = xi([k, m]);
    end % if;
    
    for l = k + 1 : n
      A(l, :) -= A(l, k) / A(k, k) * A(k, :);
    end % for;
  end % for;
  
  if A(n, n) == 0
    disp('Sistem incomp. sau sist. comp. nedet.');
    break;
  end % if;
  xraw = SubsDesc(A(1: n, 1: n), A(:, n + 1));
  
  for i = 1: n
    x(xi(i)) = xraw(i);
  end % for;
end % function;