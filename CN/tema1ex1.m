
%%%%%%%%%%%%%%%%%%%%%%
% Ex 1
%%%%%%%%%%%%%%%%%%%%%%
f = @(x) 8 * x^3 + 4*x - 1;
a = 0;
b = 1;

for i=1:2
  mid = (a + b) / 2;
  value = f(mid);
  if sign(value) == sign(f(a))
    a = mid;
  else
    b = mid;
  end % if

  if abs(a - b) < eps
    break;
  end % if
  ret = mid;
end % for

f(mid)
