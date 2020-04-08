function [EntropyFitted, EntropySample, diff_fit_sample, diff_sample_fit] = fit_sample_entropies(sample, pd_fit, PDF)
    EntropyFitted = 0;
    EntropySample = 0;
    diff_fit_sample = 0;
    diff_sample_fit = 0;
    for i=1:length(sample)
        EntropyFitted = EntropyFitted - pdf(pd_fit,sample(i))*log(pdf(pd_fit,sample(i)));
        EntropySample = EntropySample - PDF(sample(i))*log(PDF(sample(i)));
        diff_fit_sample = diff_fit_sample - pdf(pd_fit,sample(i))*(log(pdf(pd_fit,sample(i)))-log(PDF(sample(i))));
        diff_sample_fit = diff_sample_fit - PDF(sample(i))*(log(pdf(pd_fit,sample(i)))-log(PDF(sample(i))));
    end
end