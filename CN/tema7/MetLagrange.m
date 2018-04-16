function y = MetLagrange(X, Y, x)
    n = length(X);
    y = 0;
    for k = 1:n
        restul = X(1:(k - 1));
        if k < n
            restul = [restul; X((k + 1):n)];
        end
        top = prod(x * ones(n - 1, 1) - restul);
        bottom = prod(X(k) * ones(n - 1, 1) - restul);
        L = top / bottom;
        y = y + L * Y(k);
    end
end