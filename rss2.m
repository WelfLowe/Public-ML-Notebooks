function err = rss2(a,b,X,Y)
    n = length(X);
    err = 0;
    for i=1:n
        err = err + (Y(i)-a*X(i)-b)^2;
    end
end