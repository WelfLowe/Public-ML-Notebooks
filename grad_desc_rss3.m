function [as, bs, alphas, ss] = grad_desc_rss3(K, a0, b0, alpha0, s0, learning_eps, f, ff, verbose)
    as = zeros(K+1,1);
    bs = zeros(K+1,1);
    alphas = zeros(K+1,1);
    as = zeros(K+1,1);
    as(1)=a0;
    bs(1)=b0;
    alphas(1)=alpha0;
    ss(1)=s0;
    for k = 1:K
        grad_w = ff(as(k),bs(k),alphas(k),ss(k));
        grad_a = grad_w(1);
        grad_b = grad_w(2);
        grad_alpha = grad_w(3);
        grad_s = grad_w(4);
        as(k+1)= as(k) - learning_eps * grad_a;
        bs(k+1)= bs(k) - learning_eps * grad_b;
        alphas(k+1)= alphas(k) - learning_eps * grad_alpha;
        ss(k+1)= ss(k) - learning_eps * grad_s;
        if verbose
            line([as(k),as(k+1)],[bs(k),bs(k+1)])
            hold on
        end
    end
    grad_w = ff(as(k),bs(k),alphas(k),ss(k))
    ffinal = @(a,b)(f(a, b, alphas(K+1), ss(K+1)));
    if verbose
        alow = min([as.', a0-2]);
        ahigh = max([as.', a0+2]);
        blow = min([bs.', b0-3]);
        bhigh = max([bs.', b0+3]);
        [A,B] = meshgrid(alow:0.1:ahigh,blow:0.4:bhigh);
        plot3d(ffinal, A, B, false) %3D contour
    end
end