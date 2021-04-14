function plotPDF(xi, pd_fit, PDF)
    figure
    plot(xi, PDF(xi));
    hold on;
    plot(xi, pdf(pd_fit,xi));
end