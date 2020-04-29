function grad_w = grad_rss3(a, b, alpha, s, c, X, Y)
    n = length(X);
    grad_a = 0;
    grad_b = 0;
    for i=1:n
        tmp = Y(i) - a*X(i) - b;
        grad_a = grad_a + tmp *X(i);
        grad_b = grad_b + tmp;
    end
    grad_a = -2*grad_a + 2*alpha*a;
    grad_b = -2*grad_b + 2*alpha*b;
    grad_alpha = a^2 + b^2 -c +s^2;
    grad_s = 2*alpha*s;
    grad_w = [grad_a; grad_b; grad_alpha; grad_s];
end