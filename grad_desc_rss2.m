function [as, bs] = grad_desc_rss2(K, a0, b0, learning_eps, f, ff, verbose)
    as = zeros(K+1,1);
    bs = zeros(K+1,1);
    as(1)=a0;
    bs(1)=b0;
    for k = 1:K
        [grad_a, grad_b] = ff(as(k),bs(k));
        %learning_eps * [grad_a, grad_b].'
        as(k+1)= as(k) - learning_eps * grad_a;
        bs(k+1)= bs(k) - learning_eps * grad_b;
        if verbose
            line([as(k),as(k+1)],[bs(k),bs(k+1)])
            hold on
        end
    end
    if verbose
        alow = min([as.', a0-2]);
        ahigh = max([as.', a0+2]);
        blow = min([bs.', b0-9]);
        bhigh = max([bs.', b0]);
        [A,B] = meshgrid(alow:0.1:ahigh,blow:0.4:bhigh);
        plot3d_rss(f, A, B, false) %3D contour
    end
end