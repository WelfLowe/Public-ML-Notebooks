function [ws, history] = stochastic_momentum_grad_desc_mse(K, ws, learning_eps, loss, grad_loss, N, mass, verbose)
    batch_size = N*0.01;
    history(1) = loss(ws);
    v = 0;
    for k = 1:K
        randices = randsample(1:N,batch_size,false);
        grad_ws = grad_loss(ws, randices);
        v = (v+grad_ws)/2;
        old_ws = ws;
        ws= old_ws - mass * v - learning_eps * grad_ws;
        if verbose
            line([old_ws(1),ws(1)],[old_ws(2),ws(2)]);
        end
        history(k+1) = loss(ws);
    end
end