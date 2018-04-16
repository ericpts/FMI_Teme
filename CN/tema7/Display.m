function [x_grafic, E] = Display(n, a, b, f, Met, nume)
    hold on;
    x_grafic = linspace(a, b, 100)';

    x_calcul = linspace(a, b, n + 1)';
    y_calcul = f(x_calcul);
    
    plot(x_grafic, f(x_grafic), 'r-');
    plot(x_calcul, y_calcul, 'rx');
    
    y_polinom = zeros(100, 1);
    for i = 1:100
        y_polinom(i) = Met(x_calcul, y_calcul, x_grafic(i));
    end
    plot(x_grafic, y_polinom, 'g-');
    legend("f", "puncte", nume);
    title(nume);
    
    E = f(x_grafic) - y_polinom;
end

