function [ws, history] = grad_desc_mse(K, ws, learning_eps, loss, grad_loss)
    history(1) = loss(ws);
    for k = 1:K
        grad_ws = grad_loss(ws);
        ws= ws - learning_eps * grad_ws;
        history(k+1) = loss(ws);
    end
end