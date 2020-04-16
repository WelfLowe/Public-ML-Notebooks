function grad_err = grad_rss(a, X, Y)
    n = length(X);
    grad_err = 0;
    for i=1:n
        grad_err = grad_err + (Y(i) - a*X(i))*X(i);
    end
    grad_err = -2*grad_err;
end