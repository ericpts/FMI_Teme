
function ret = MetNR(f, df, x0, eps)
  while true
    xn = x0 - f(x0) / df(x0);
    if abs(xn - x0) < eps * abs(x0)
      break;
    end %if
    x0 = xn;
  end %while
  ret = x0;
end %function

