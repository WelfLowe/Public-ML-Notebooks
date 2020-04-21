function ab = newton_rss2(K, a0, b0, H, f, ff, verbose)
    H_inv = inv(H);
    ab = zeros(2,K+1);
    ab(1,1)=a0;
    ab(2,1)=b0;
    for k = 1:K
        [grad_a, grad_b] = ff(ab(1,k),ab(2,k));
        %H_inv * [grad_a, grad_b].'
        ab(:,k+1)= ab(:,k) - H_inv * [grad_a, grad_b].';
        if verbose
            line([ab(1,k),ab(1,k+1)],[ab(2,k),ab(2,k+1)])
            hold on
        end
    end
    if verbose
        alow = min([ab(1,:), a0-2]);
        ahigh = max([ab(1,:), a0+2]);
        blow = min([ab(2,:), b0-9]);
        bhigh = max([ab(2,:), b0+0]);
        [A,B] = meshgrid(alow:0.1:ahigh,blow:0.4:bhigh);
        plot3d(f, A, B, false) %3D contour
    end
end