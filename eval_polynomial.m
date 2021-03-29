
function y = eval_polynomial(x,beta)
    n = length(beta);
    y = 0;
    for i=1:n
        y = y + x.^(n-i) * beta(i);
    end
end