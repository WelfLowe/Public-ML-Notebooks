function [ws, history] = ada_grad_mse(K, ws, learning_eps, loss, grad_loss, N, verbose)
    batch_size = N*0.01;
    history(1) = loss(ws);
    r = zeros(length(ws),1);
    delta = 1e-10*ones(length(ws),1);
    for k = 1:K
        randices = randsample(1:N,batch_size,false);
        grad_ws = grad_loss(ws, randices);
        old_ws = ws;
        r = r + grad_ws .* grad_ws; 
        ws= old_ws - learning_eps/(delta+sqrt(r)) .* grad_ws;
        if verbose
            line([old_ws(1),ws(1)],[old_ws(2),ws(2)]);
        end
        history(k+1) = loss(ws);
    end
end