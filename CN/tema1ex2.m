f = @(x) x^3 - 7 * x^2 + 14*x - 6;
a = 0;
b = 4;
n = 1000;

x = a:(b-a)/n:b;
y = arrayfun(f, x);

eps = 1e-5;
intervals = [
  [0,1],
  [1,3.2],
  [3.2,4],
];

xaprox = [];
yaprox = [];

for i=1:rows(intervals)
  row = intervals(i, :);
  xnow = MetBisectie(f, row(1), row(2), eps);
  xaprox = [xaprox, xnow];
  yaprox = [yaprox, f(xnow)];
end % for

plot(x, y);

hold;

plot(xaprox, yaprox, "or");