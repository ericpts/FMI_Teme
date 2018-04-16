

y1 = @(x) exp(x) - 2;
y2 = @(x) cos(exp(x) - 2);


a = 0;
b = 2;
n = 50;


f = @(x) y1(x) - y2(x);
sol = MetBisectie(f, 0.5, 1.5, 1e-5);

x = a:(b-a)/n:b;

plot(x, arrayfun(y1, x));
hold on;
plot(x, arrayfun(y2, x));

printf("Am gasit %f cu y1() = %f si y2() = %f\n", sol, y1(sol), y2(sol));