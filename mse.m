function err = mse(ws,m,X,Y)
    N = length(X);
    err = 0;
    for i=1:N
        xi=X(i,:);
        yi=m(ws,xi);
        err = err + (Y(i)-yi)^2;
    end
    err = err/N;
end