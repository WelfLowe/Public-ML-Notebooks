function err = rss(a,X,Y)
    n = length(X);
    err = 0;
    for i=1:n
        err = err + (Y(i)-a*X(i))^2;
    end
end