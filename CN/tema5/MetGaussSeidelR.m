function [x_aprox, N] = MetGaussSeidelR(A, a, eps, sigma)
    n = length(A);
    x_aprox = zeros(n, 1);
    N = 0;
    if (sigma < 0 || sigma > 2)
        print('Metoda nu converge.'); 
        return;
    end
    
    x_old = zeros(n, 1);
    x_new = zeros(n, 1);
    k = 1; 
    
    D = diag(diag(A)); % diagonala
    L = tril(A - D); % triunghiul inferior
    R = triu(A - D); % triunghiul superior
    
    % x(k) = B * x(k-1) + b
    B = ((1 - sigma) * D - sigma * R) / (sigma * L + D);
    q = norm(B);
    
    error_factor = 1;
   
    while 1
        x_new = zeros(n, 1);
        k = k + 1;
        for i = 1:n
            sum1 = [zeros(1, i) A(i, (i+1):n)] * x_old;
            sum2 = [A(i, 1:(i - 1)) zeros(1, n - i + 1)] * x_new;
            delta = sigma / A(i, i) * (a(i) - sum1 - sum2);
            x_new(i) = (1 - sigma) * x_old(i) + delta;
        end
        if k == 2
            error_factor = norm(x_new - x_old);
        end
        x_old = x_new;
        if  q^k /(1 - q) * error_factor < eps
            break;
        end
    end
    
    x_aprox = x_new;
    N = k;
end