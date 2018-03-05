
f = @(x) x^3 - 7* x^2 + 14*x - 6;
df = @(x) 3 * x^2 - 14 * x + 14;
ddf = @(x) 6*x - 14;


a = 0;
b = 4;
n = 100;

x = a: (b-a) / n: b;

plot(x, arrayfun(f, x));

intervals = [
  [0.0, 1.5],
  [1.5, 3.1],
  [3.1, 4.0],
];

inits = [
  0,
  2.9,
  3.5,
];

sols = [];

for i=1:rows(intervals)
  row = intervals(i, :);
  a = row(1);
  b = row(2);
  x0 = inits(i);
  
  assert(f(a) * f(b) < 0);
  assert(f(x0) * ddf(x0) > 0);
  sols = [sols, MetNR(f, df, x0, 1e-3)];
end %for

plot(x, arrayfun(@(x) f(x) * ddf(x), x));
hold;
plot(sols, arrayfun(f, sols), "ro");

printf("Am gasit solutiile: ");
disp(sols);