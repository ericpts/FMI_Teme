%Ex1
A1 = [1,2,4;3,8,14;2,6,13];
b = [1;2;3];
[x,L,U] = DescLU(A1,b)
%[x,L] = DescCholesky(A1,b);
%[x,Q,R] = DescQR(A1,b);

%Ex2
A2= [4,2,2;2,10,4;2,4,6];
%[x,L,U] = DescLU(A2,b);
[x,L] = DescCholesky(A2,b)
%[x,Q,R] = DescQR(A2,b);

%Ex3
A3 = [0,4,5;-1,-2,-3;0,0,1];
%[x,L,U] = DescLU(A3,b);
%[x,L] = DescCholesky(A3,b);
[x,Q,R] = DescQR(A3,b)