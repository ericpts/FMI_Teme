function [x_aprox, N] = MetJacobi(A, a, eps)
    x_aprox = zeros(1, size(A, 1));
    N = 0;
    I = eye(size(A));
    q = norm(I-A);
    if q >= 1
       disp('Metoda Jacobi nu asigura convergenta')
       return
    end
    
    B = I - A;
    b = a;
 
    x_old = B * zeros(size(A, 1), 1) + b;
    error_factor = x_old;
    k = 2;
    while 1
        k = k + 1;
        x_new = B * x_old + b;
        if q^k / (1 - q) * norm(error_factor) < eps
            break
        end
        x_old = x_new;
    end
    x_aprox = x_old;
    N = k;
end