function H = hessian_mse(ws, X)
    N = length(X);
    M = length(ws);
    H = zeros(M);
    for r=1:M
        for c=1:M
            for i=1:N
                H(r,c) = H(r,c) + X(i,r)*X(i,c);
            end
        end
    end
    H = 2/N*H;
end