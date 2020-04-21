function a = accuracy(X,Y,f)
    correct = 0;
    for i=1:length(X)
        y = f(X(i,1),X(i,2));
        if y==Y(i)
            correct = correct +1;
        else
            fprintf("f(%d,%d)=%d, but should be %d\n", X(i,1),X(i,2), y, Y(i))
        end
    end
    a=correct/length(X);
end