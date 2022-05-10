function grad = grad_L(x, l)
    grad_x = 2*x+2*x*l;
    grad_l = x^2-1;
    grad = [grad_x; grad_l];
end