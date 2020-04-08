function PDF = samplePDF(sample, pd_fit, verbose)
    [f,xi] = ksdensity(sample); 
    PDF = griddedInterpolant(xi,f);
    if (verbose)
        figure
        plot(xi, PDF(xi));
        hold on;
        plot(xi, pdf(pd_fit,xi));
    end
end