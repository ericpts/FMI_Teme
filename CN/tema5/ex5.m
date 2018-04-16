% 2

% a
A = [ 0.2 0.01 0;
      0   1    0.04;
      0   0.02 1 ];
a = [1; 2; 3];
eps = 1e-5;

[x_aprox, N] = MetJacobi(A, a, eps);

% norm(I - A) < 1, deci metoda converge.

% b
A = [4 1 2;
     0 3 1;
     2 4 8];

[x_aprox, N] = MetJacobiDDL(A, a, eps);

% Matricea e diagonal dominanta pe linii, deci metoda converge.

% c
A = [4  2 2;
     2 10 4;
     2  4 6];
sigma = 0.0025;
[x_aprox, N] = MetGaussSeidelR(A, a, eps, sigma);
[x_aprox, N] = MetJacobiR(A, a, eps, sigma);

% Sigma e suficient de mic ca să meargă.


% 3
% Figure 1.

figure;
hold on;

l = 2 / norm(A, inf);

steps=10;
[x_aprox, N, sigma, V] = MetJacobiRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'r+');

steps=20;
[x_aprox, N, sigma, V] = MetJacobiRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'bo');


steps=50;
[x_aprox, N, sigma, V] = MetJacobiRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'gx');

legend("10 intervale", "20 intervale", "50 intervale");
xlabel("sigma");
ylabel("niter");
title("Met Jacobi, 2 / Norma");

% Cu raza spectrala.
figure;
hold on;

l = 2 / max(abs(eigs(A)));

steps=10;
[x_aprox, N, sigma, V] = MetJacobiRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'r+');

steps=20;
[x_aprox, N, sigma, V] = MetJacobiRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'bo');

steps=50;
[x_aprox, N, sigma, V] = MetJacobiRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'gx');

legend("10 intervale", "20 intervale", "50 intervale");
xlabel("sigma");
ylabel("niter");

title("Met Jacobi, 2 / Raza spectrala");
% nu merge pentru că sigma > 2 / normă

% 4
[x_aprox, N] = MetJacobiRO(A, a, eps, 50);

disp(x_aprox);
disp(N);

% 5
figure;
hold on;

l = 2 / norm(A, inf);

steps=10;
[x_aprox, N, sigma, V] = MetGaussSeidelRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'r+');

steps=20;
[x_aprox, N, sigma, V] = MetGaussSeidelRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'bo');

steps=50;
[x_aprox, N, sigma, V] = MetGaussSeidelRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'gx');

legend("10 intervale", "20 intervale", "50 intervale");
xlabel("sigma");
ylabel("niter");

title("Met Gauss Seidel, 2 / Norma");

% Raza spectrala.
figure;
hold on;

l = 2 / max(abs(eigs(A)));

steps=10;
[x_aprox, N, sigma, V] = MetGaussSeidelRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'r+');

steps=20;
[x_aprox, N, sigma, V] = MetGaussSeidelRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'bo');

steps=50;
[x_aprox, N, sigma, V] = MetGaussSeidelRO(A, a, eps, steps, l);
plot((1:steps) * 1/steps * l, V, 'gx');

legend("10 intervale", "20 intervale", "50 intervale");
xlabel("sigma");
ylabel("niter");

title("Met Gauss Seidel, 2 / Raza spectrala");
% Merge pentru că sigma < 2.

[x_aprox, N] = MetGaussSeidelRO(A, a, eps, 50);
disp(x_aprox);
disp(N);
