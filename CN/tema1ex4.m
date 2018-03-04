
f = @(x) x^2 - 3;

a = -1;
b = 3;

sol = MetBisectie(f, a, b, 1e-6);

printf("Am gasit solutia %f pentru sqrt(3). (%f)^2 = %f\n", sol, sol, sol^2);