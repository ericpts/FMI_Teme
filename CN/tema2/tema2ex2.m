
f = @(x) x.^3 - 18 * x - 10;
df = @(x) 3*x^2 - 18;
ddf = @(x) 6*x;

a = -5;
b = 5;
eps = 1e-3;

% d.

% f'(x) = 0 <=> 3x^2 = 18 <=> x = +- sqrt(6) ~ 2.44

a0 = -5;
b0 = -2.5;
x0 = MetSecantei(f, a0, b0, -5, -4, eps)
assert (a0 <= x0 && x0 <= b0);

a1 = -2.3;
b1 = 2.2;
x1 = MetSecantei(f, a1, b1, a1, b1, eps)
assert (a1 <= x1 && x1 <= b1);

a2 = 3;
b2 = 5;
x2 = MetSecantei(f, a2, b2, a2, b2, eps)
assert (a2 <= x2 && x2 <= b2);

plot(x0, f(x0), 'bx');
hold on;
plot(x1, f(x1), 'bx');
hold on;
plot(x2, f(x2), 'bx');
hold on;
fplot(f, [a b]);

% e.
assert(f(a) * f(b) < 0);
% f'' = 0 <=> 6x = 0 <=> x = 0
x0 = MetPozFalse(f, -5, -2.5, eps);
x1 = MetPozFalse(f, -2.3, -0.1, eps);
x2 = MetPozFalse(f, 3, 5, eps);

hold on;
plot(x0, f(x0), 'rx');
hold on;
plot(x1, f(x1), 'rx');
hold on;
plot(x2, f(x2), 'rx');
hold on;