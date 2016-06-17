function out=containsWhite(image)
    [X,Y] = size(image);
    out=0;
    for x = 1:X
        for y = 1:Y
            if(image(x,y)==1)
                out=1;
                return;
            end
        end
    end
end