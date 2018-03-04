
function ret = MetBisectie(f, a, b, eps)
  assert(f(a) * f(b) <= 0);
  while true
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
   end % for
   ret = mid;  
end