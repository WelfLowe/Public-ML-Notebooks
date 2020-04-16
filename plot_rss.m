function plot_rss(f,a_range)
    err_range = arrayfun(f,a_range);
    plot(a_range,err_range)
end