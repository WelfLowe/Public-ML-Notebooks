function res = ite(cond, tc, fc)
    if (cond)
        res = tc;
    else
        res = fc;
    end
end