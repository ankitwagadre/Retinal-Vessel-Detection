function closeMap=getCloseMap(image)
    [X,Y,Z] = size(image);
    closeMap = zeros(X,Y,2);
        
    for x=1:X
        for y=1:Y
            [xloc,yloc]=getNearestPixel(image,x,y);
            closeMap(x,y,1)= xloc;
            closeMap(x,y,2)= yloc;
        end
    end
end