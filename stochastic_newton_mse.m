function [ws, history] = stochastic_newton_mse(K, ws, loss, grad_loss, grad2_loss, N, verbose)
    batch_size = N*0.01;
    history(1) = loss(ws);
    for k = 1:K
        randices = randsample(1:N,batch_size,false);
        grad_ws = grad_loss(ws, randices);
        old_ws = ws;
        H = grad2_loss(ws, randices);
        ws= old_ws - inv(H) * grad_ws;
        if verbose
            line([old_ws(1),ws(1)],[old_ws(2),ws(2)]);
        end
        history(k+1) = loss(ws);
    end
end