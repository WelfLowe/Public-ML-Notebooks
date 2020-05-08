function [ws, history] = cg_mse(K, ws, loss, stochastic_loss, grad_loss, N, verbose)
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
        %Naive line search for epsilon* = argmin stochastic_loss(ws+epsilon * rho)
        epsilon_star = 0.00001;
        minimum_star = stochastic_loss(ws+epsilon_star*rho,randices);
        for epsilon = 0.00001:0.0001:1
            minimum = stochastic_loss(ws+epsilon*rho,randices);
            if minimum < minimum_star
                epsilon_star = epsilon;
                minimum_star = minimum;
            end
        end
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