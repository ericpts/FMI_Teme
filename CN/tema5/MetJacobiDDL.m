function [x_aprox, N] = MetJacobiDDL(A, a, eps)
    n = size(A,1);
    x_aprox = zeros(1, n);
    N = 0;
    for i = 1:n
       if abs(A(i,i)) < sum(A(i,:)) - A(i, i)
           disp('Matricea nu este diag. dom. pe linii')
           return
       end
    end
    I = eye(size(A));
    B = I - A ./ repmat(diag(A), 1, n);
    b = a ./ diag(A);
    x_old = B * zeros(size(A, 1), 1) + b;
    error_factor = norm(x_old, 2);
    k = 1;
    q = norm(B, inf);
    while 1
        x_new = B * x_old + b;
        k = k+1;
        if q^k / (1 - q) * error_factor < eps
            break;
        end
        x_old = x_new;
    end
    
    x_aprox = x_new;
    N = k;
end
