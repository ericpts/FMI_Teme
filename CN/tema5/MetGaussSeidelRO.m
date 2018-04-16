function [x_aprox, N, sigma, V] = MetGaussSeidelRO(A, a, eps, p, l)
    n = length(A);
    V = zeros(n,1);
    
    if nargin == 4
        l = 2 / norm(A, inf);
    end
    
    for s = 1 : p
        sigma = l * s / p;
        [~, N] = MetGaussSeidelR(A, a, eps, sigma);
        V(s) = N;
    end
    
    [~, position] = max(V);
    sigma = l * position / p;
    [x_aprox, N] = MetGaussSeidelR(A, a, eps, sigma);
end