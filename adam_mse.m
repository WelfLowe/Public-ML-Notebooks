function [ws, history] = adam_mse(K, ws, learning_eps, loss, grad_loss, N, rho1, rho2, verbose)
    batch_size = N*0.01;
    history(1) = loss(ws);
    s = zeros(length(ws),1);
    r = zeros(length(ws),1);
    t = 0;
    delta = 1e-10*ones(length(ws),1);
    for k = 1:K
        randices = randsample(1:N,batch_size,false);
        grad_ws = grad_loss(ws, randices);
        old_ws = ws;
        t = t +1;
        s = rho1*s + (1-rho1) * grad_ws; 
        r = rho2*r + (1-rho2) * grad_ws .* grad_ws; 
        s_hat = s/(1-rho1^t);
        r_hat = r/(1-rho2^t);
        ws= old_ws - (learning_eps*s_hat)/(delta+sqrt(r));
        if verbose
            line([old_ws(1),ws(1)],[old_ws(2),ws(2)]);
        end
        history(k+1) = loss(ws);
    end
end