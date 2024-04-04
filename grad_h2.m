function grad = grad_h2(x, l)
    grad_x = 4*x*(x^2+2*l^2+4*l+1);
    grad_l = 8*x^2*(l+1);
    grad = [grad_x; grad_l];
end