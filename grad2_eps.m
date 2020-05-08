function grad2_eps = grad2_eps(rho, X)
    N = length(X);
    grad2_eps = 0;
    for i=1:N
        xi = X(i,:);
        tmp = rho'*xi';
        grad2_eps = grad2_eps + tmp^2;
    end
    grad2_eps = 2/N*grad2_eps;
end