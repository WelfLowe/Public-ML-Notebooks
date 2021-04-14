function I = simpson(f, a, b) %3/8 rule
    N = 3*(b-a)*100+1;
    x = linspace(a,b,N);
    dx = x(2)-x(1);
    I = 0;
    for i=1:3:N-3
        z0 = f(x(i));
        z1 = f(x(i+1));
        z2 = f(x(i+2));
        z3 = f(x(i+3));
        I = I+z0+3*z1+3*z2+z3;
    end
    I = I*(3*dx/8);
end