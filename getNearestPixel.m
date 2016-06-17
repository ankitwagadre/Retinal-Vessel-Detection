function [xloc,yloc] = getNearestPixel(image,x,y)
    %A return of -1 means always prune
    global MAXD;
    dout = 1;
    dfinal=32767;%intmax('int32');
    dmin =32767; %intmax('int32');
    
    try
        if(image(x,y)==1)
            xloc=x;
            yloc=y;
            return;
        end
    catch err
    end
    
    while(dout <= dfinal)
        for d=-1*dout:dout
            for l=0:3
                if(l==0)
                    dx=dout;
                    dy=d;
                elseif(l==1)
                    dx=-1*dout;
                    dy=d;
                elseif(l==2)
                    dx=d;
                    dy=-1*dout;
                elseif(l==3)
                    dx=d;
                    dy=dout;
                else
                    disp('Fatal error in getNearestPixel()');
                end
            
                %For each pixel in our square region
                try
                    if(image(x+dx,y+dy)==1)
                        %if we have a white pixel
                        if(dfinal==32767)
                            dfinal=dout*sqrt(2); %we want to stop once we've reached twice our dout;
                            dmin = getDistance(x,y,x+dx,y+dy);
                            xloc = x+dx;
                            yloc = y+dy;
                        else
                            dtemp = getDistance(x,y,x+dx,y+dy);
                            if(dtemp < dmin)
                                %it is a better distance
                                dmin=dtemp;
                                xloc = x+dx;
                                yloc = y+dy;
                            end
                        end
                    end
                catch err
                    continue;
                end
            end
        end
        
        if(dout>=MAXD*sqrt(2) && dfinal==32767)
            xloc = -1; 
            yloc = -1;
            return;
        end
        
        dout = dout + 1;
    end
end