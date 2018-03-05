function ret = MetPozFalse(f, a, b, eps)
  cond = 1;
  k = 0;
  x = (a * f(b) - b * f(a)) / (f(b) - f(a));
  while cond == 1
    k = k + 1;
    if f(x) == 0
      ret = x;
      break;
    end % if
    
    if f(a) * f(x) < 0
      b = x;
    elseif f(a) * f(x) > 0
      a = x;
    end % if 
    
    newx = (a * f(b) - b * f(a)) / (f(b) - f(a));
    
    if abs(newx - x) >= eps * abs(x)
      cond = 1;
    else
      cond = 0;
    end % if
    
    x = newx;
  end % while
  ret = x;
end % function