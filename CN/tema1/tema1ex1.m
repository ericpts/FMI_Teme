
%%%%%%%%%%%%%%%%%%%%%%
% Ex 1
%%%%%%%%%%%%%%%%%%%%%%
f = @(x) 8 * x^3 + 4*x - 1;
a = 0;
b = 1;

a0 = 0;
b0 = 1;
mid0 = 0.5;
f(a0) % = -1;
f(b0) % = 11;
f(mid0) % = 2 > 0

a1 = 0;
b1 = 0.5;
mid1 = 0.25;
f(a1) % = -1;
f(b1) % = 2;
f(mid1) %  = 0.1250 > 0

a2 = 0;
b2 = 0.25;
mid2 = 0.125;

f(mid2) % = -0.4844
