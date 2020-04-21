function plot3d(f,A,B,real3d)
    Z = arrayfun(f,A,B);
    if real3d
        surf(A,B,Z)
    else
        contour(A,B,Z)
    end
    colorbar
end