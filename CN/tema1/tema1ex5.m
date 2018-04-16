
f = @(x) x^3 - 7 * x^2 + 14 * x - 6;
df = @(x) 3 * x^2 - 14 * x + 14;
ddf = @(x) 6 * x - 14;

% Metoda NR imi gaseste solutia 3 din primul pas, pentru ca
% f(2) = 2, df(2) = -2, si urmatorul x din sir este 3, care e si solutie.
disp(MetNR(f, df, 2, 1e-4));

% Deoarece f * f'' < 0
sign(f(2) * ddf(2))


ansmic = disp(MetNR(f, df, 0, 1e-4));
disp(ansmic);
% Solutia in intervaul 0, 2.5 este 0.58579.