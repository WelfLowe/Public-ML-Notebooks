function [ws, history] = cg_mse_newton(K, ws, loss, grad_loss, stochastic_grad_eps, stochastic_grad2_eps, N, verbose)
    %initialization
    batch_size = N*0.01;
    history(1) = loss(ws);
    %we only need variables at t (var) and t-1 (var_old) 
    rho_old = zeros(length(ws),1);
    grad_ws_old = zeros(length(ws),1);
    
    for k = 1:K
        randices = randsample(1:N,batch_size,false);
        %Compute gradient
        grad_ws = grad_loss(ws, randices);
        if k==1
            %Linear cg, i.e., no search direction adjustment in the first round
            rho = - grad_ws;
        else
            %Compute Polak-Ribière
            beta = ((grad_ws - grad_ws_old)' * grad_ws) /(grad_ws_old' * grad_ws_old);
            %Compute search direction
            rho = - grad_ws + beta*rho_old;
        end
        %Newton line search for epsilon* = argmin stochastic_loss(ws+epsilon * rho)
        %Just one iteration as the (stochastic) loss function is quadratic in epsilon
        epsilon_star = 0.5;
        grad_eps = stochastic_grad_eps(epsilon_star, ws, rho, randices);
        h = stochastic_grad2_eps(rho, randices);
        epsilon_star = epsilon_star - grad_eps/h;

        %Remember parameters (for drawing the line of this step if verbose) 
        old_ws = ws;
        %Update the parameters
        ws= old_ws + epsilon_star * rho;
        %Remember the variables at t as the old variables at t-1 in the next iteration 
        rho_old = rho;
        grad_ws_old = grad_ws;
        %Draw the line 
        if verbose
            line([old_ws(1),ws(1)],[old_ws(2),ws(2)]);
        end
        history(k+1) = loss(ws);
    end
end