function [xs, ls] = grad_desc_h(K, x0, l0, learning_eps, f, ff, verbose)
    xs = zeros(K+1,1);
    ls = zeros(K+1,1);
    xs(1)=x0;
    ls(1)=l0;
    for k = 1:K
        grad = ff(xs(k),ls(k));
        grad_x = grad(1);
        grad_l = grad(2);
        %learning_eps * [grad_a, grad_b].'
        xs(k+1)= xs(k) - learning_eps * grad_x;
        ls(k+1)= ls(k) - learning_eps * grad_l;
        if verbose
            line([xs(k),xs(k+1)],[ls(k),ls(k+1)])
            hold on
        end
    end
    if verbose
        xlow = min([xs.', -2]);
        xhigh = max([xs.', +2]);
        llow = min([ls.', -2]);
        lhigh = max([ls.', 0.5]);
        [A,B] = meshgrid(xlow:0.1:xhigh,llow:0.1:lhigh);
        plot3d(f, A, B, false) %3D contour
    end
end