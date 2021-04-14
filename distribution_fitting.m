function pd = distribution_fitting(feature)
    distnames =["Normal","Poisson", "Exponential", "Gamma", "ExtremeValue", "Kernel"];
    values_must_be_positive =["Poisson", "Exponential", "Gamma"];
    x=feature.';
    x_values = linspace(min(x),max(x));
    for dn=distnames
        if min(x)<0 & ~isempty(find(strcmp(dn, values_must_be_positive)))
          continue;
        end
        distname = char(dn);
        pd = fitdist(x.',distname);
        res1=kstest(x, 'CDF', pd); 
        res2=chi2gof(x, 'CDF', pd);
        if (~res1 && ~res2)
            fprintf('%s with 5%% significance level\r',distname);
            cdfplot(x)
            hold on
            plot(x_values,cdf(pd,x_values),'r-')
            plot(x_values,pdf(pd,x_values),'g-')
            legend('Empirical CDF',[distname ' CDF'],[distname ' PDF'],'Location','best');
            title(['Empirical CDF and ', [distname ' CDF/PDF']]);
            hold off 
            return;
        else 
            fprintf('Not %s with 5%% significance level\n',distname);
        end
    end
end