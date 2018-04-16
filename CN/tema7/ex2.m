f = inline('sin(x)', 'x');
n = 10;
a = -pi / 2;
b = pi / 2;

figure;

subplot(2, 2, 1);
[x_dir, e_dir] = Display(n, a, b, f, @MetDirecta, "Metoda Directa");

subplot(2, 2, 2);
[x_lag, e_lag] = Display(n, a, b, f, @MetLagrange, "Metoda Lagrange");

subplot(2, 2, 3);
[x_n, e_n] = Display(n, a, b, f, @MetN, "Metoda Newton");

subplot(2, 2, 4);
[x_ndd, e_ndd] = Display(n, a, b, f, @MetNDD, "Metoda NDD");

xlabel("x");
xlabel("y");

figure;

subplot(2, 2, 1);
plot(x_dir, e_dir, 'r-');
title("Metoda Directa");

subplot(2, 2, 2);
plot(x_lag, e_lag, 'r-');
title("Metoda Lagrange");

subplot(2, 2, 3);
plot(x_n, e_n, 'r-');
title("Metoda Newton");

subplot(2, 2, 4);
plot(x_ndd, e_ndd, 'r-');
title("Metoda NDD");

% n max pentru care Pn se aproprie de f e:
% 62 pentru Metoda Newton
% 66 pentru Metoda Lagrange
% 71 pentru Metoda NDD
% 71 pentru Metoda Directă
