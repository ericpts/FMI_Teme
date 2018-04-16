function [x_aprox, N] = MetJacobiR(A, a, eps, sigma)
    n = length(A);
    x_aprox = zeros(n, 1);
    N = 0;
    
    if(sigma < 0 || sigma > 2/ norm(A, inf))
        display('Metoda nu converge.');
        return;
    end
    
    b = sigma * a;
    B = eye(n) - sigma * A;
    
    x_old = B * zeros(n, 1) + b;
    x_new = x_old;
    k = 1;
   
    while 1
        k = k + 1;
        x_new = B * x_old + b;
        if norm(x_new - x_old) < eps * norm(x_old)
            break;
        end
        x_old = x_new;
    end
    
    x_aprox = x_new;
    N = k;
end