function I = trapez(f, a, b)
    N = (b-a)*100;
    x = linspace(a,b,N);
    dx = x(2)-x(1);
    for i=1:N
        z = f(x(i));
        y(i) = z;
    end
    w = [0.5 ones(1,N-2) 0.5];
    I = sum(w.*y)*dx;
end