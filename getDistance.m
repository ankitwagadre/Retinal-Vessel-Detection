function dist=getDistance(x1,y1,x2,y2)
    x=x1-x2;
    y=y1-y2;
    
    dist = sqrt(x*x+y*y);
end