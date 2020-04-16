function as = grad_desc_rss(K, a0, learning_eps, f, ff, verbose)
    as = zeros(K+1,1);
    as(1)=a0;
    for k = 1:K
        as(k+1)= as(k) - learning_eps * ff(as(k));
        if verbose
            line([as(k),as(k+1)],[f(as(k)),f(as(k+1))], 'LineStyle', ':')
%            plot (as(k+1), f(as(k+1)),'x');
            hold on
        end
    end
    if verbose
        a_range = min(as)-1:0.1:max(as)+1;
        plot_rss(f,a_range)
        fff = @(a)((a-a0)*ff(a0)+f(a0));
        a_range = a0-1:0.1:a0+1;
        plot_rss(fff,a_range)
        fff = @(a)((a-as(k+1))*ff(as(k+1))+f(as(k+1)));
        a_range = as(k+1)-1:0.1:as(k+1)+1;
        plot_rss(fff,a_range);
    end
end