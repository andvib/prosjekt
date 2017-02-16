function [x, y] = createCircle(x, y, r, nsegments)
    th = 0:pi/1000:2*pi;
    
    x = r*cos(th) + x;
    y = r*sin(th) + y;