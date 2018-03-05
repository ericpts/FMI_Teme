f = @(x) 8 * x^3 + 4 * x - 1;
df = @(x) 24 * x^2 + 4;
ddf = @(x) 48 * x;

a = 0;
b = 1;
x0 = 0.8;
npoints = 50;

assert(f(a) * f(b) < 0);
assert(f(x0) * ddf(x0) > 0);
% Ex1.a. Din Teorma I.2 rezulta ca f(x) = 0 are solutie unica pe [a, b].

% Newton Rhapson: 
x1NR = x0 - f(x0) / df(x0);
x2NR = x1NR - f(x1NR) / df(x1NR)

% Metoda secantei: 
x1Secanta = 0.9;
x2Secanta = (x1Secanta * f(x0) - x0 * f(x1Secanta)) / (f(x0) - f(x1Secanta))

% Metoda pozitiei false:
a0 = a;
b0 = b;
x0 = (a0 * f(b0) - b0 * f(a0)) / (f(b0) - f(a0));

if f(a0) * f(x0) < 0
  a1 = a0;
  b1 = x0;
elseif f(a0) * f(x0) > 0
  a1 = x0;
  b1 = b0;
end % if 
x1 = (a1 * f(b1) - b1 * f(a1)) / (f(b1) - f(a1));
  

if f(a1) * f(x1) < 0
  a2 = a1;
  b2 = x1;
elseif f(a1) * f(x1) > 0
  a2 = x1;
  b2 = b1;
end % if 
x2 = (a2 * f(b2) - b2 * f(a2)) / (f(b2) - f(a2));
  
x2PF = x2


