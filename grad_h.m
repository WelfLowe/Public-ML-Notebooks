function grad = grad_h(x, l)
    grad_x = 2*x*(x^2+2*l^2+4*l+1);
    grad_l = 4*x^2*(l+1);
    grad = [grad_x/sqrt(x^4+x^2*(4*l^2 +8*l+2)+1); grad_l/sqrt(x^4+x^2*(4*l^2 +8*l+2)+1)];
end