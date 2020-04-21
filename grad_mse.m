function grad_ws = grad_mse(ws, m, grads, X, Y)
    N = length(X);
    M = length(ws);
    grad_ws = zeros(M,1);
    for i=1:N
        xi = X(i,:);
        yi = Y(i);
        tmp = yi - m(ws,xi);
        for j=1:M
            grad_ws(j) = grad_ws(j) + tmp*grads{j}(ws,xi);
        end
    end
    grad_ws = -1/2*grad_ws;
end