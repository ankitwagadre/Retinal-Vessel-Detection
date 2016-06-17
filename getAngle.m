function phi=getAngle(x1,y1,x2,y2,x3,y3)
    pepDist = getDistance(x1,y1,x2,y2);
    penDist = getDistance(x1,y1,x3,y3);
    top = dot([x1-x2,y1-y2],[x1-x3,y1-y3]);
    phi = (180/pi) * acos(top/(penDist*pepDist));
end