function PDF = parzanPDF(sample, pd_fit, a, b, h, verbose)
    x = a:.1:b;
    mu = 0;
    sigma = 1;
    len_x = length(x);
    len_s = length(sample);
    f = zeros(1, len_x);
    for j=1:len_x
        xi=x(j);
        % Use a Gaussian Kernal function
        for i=1:len_s
            f(j) = f(j) + normpdf((xi-sample(i))/h,mu,sigma);
        end
        f(j) = f(j) /(len_s*h);
    end
    PDF = griddedInterpolant(x,f);
    if (verbose)
        plotPDF(x, pd_fit, PDF);
    end
end