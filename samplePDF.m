function PDF = samplePDF(sample, pd_fit, verbose)
    [f,xi] = ksdensity(sample);
    PDF = griddedInterpolant(xi,f);
    if (verbose)
        plotPDF(xi, pd_fit, PDF);
    end
end