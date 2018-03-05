%b
A1 = [0 1 1;2 1 5;4 2 1];
b1 = [3;5;1];
x_1a = GaussPivTot(A1,b1)
x_1b = GaussPivPart(A1,b1)
x_1c = GaussFaraPiv(A1,b1)

A2 = [0 1 -2;1 -1 1; 1 0 -1];
b2 = [4;6;2];
x_2a = GaussPivTot(A2,b2)
x_2b = GaussPivPart(A2,b2)
x_2c = GaussFaraPiv(A2,b2)

%c
eps = 10^(-20);
A1c = [eps 1;1 1];
b1c = [1;2];
x_1c1 = GaussPivPart(A1c,b1c)
x_1c2 = GaussFaraPiv(A1c,b1c)

C = 10^20;
A2c = [2 2*C;1 1];
b2c = [2*C;2];
x_2c1 = GaussPivTot(A2c,b2c)
x_2c2 = GaussPivPart(A2c,b2c)
x_2c3 = GaussFaraPiv(A2c,b2c)