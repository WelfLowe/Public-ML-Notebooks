function grad_eps = grad_eps(eps, ws, rho, m, grad, X, Y)
    N = length(X);
    grad_eps = 0;
    for i=1:N
        xi = X(i,:);
        yi = Y(i);
        tmp = yi - m(ws+eps*rho,xi);
        grad_eps = grad_eps + tmp*grad(rho,xi);
    end
    grad_eps = -2/N*grad_eps;
end