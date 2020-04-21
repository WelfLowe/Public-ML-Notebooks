function y = hidden_layer(ws,x,n)
    y = zeros(n,1);
    for i=1:n
        i1 = (i-1)*3+1;
        i2 = (i-1)*3+2;
        i3 = (i-1)*3+3;
        y(i) = ws(i1)*x(1)+ws(i2)*x(2)+ws(i3);%m1
    end
end