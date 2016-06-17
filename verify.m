function out = verify(image,original)
    global MAXD;
    global MAXPHI;
    global PSIZE;
    global CMIN;
    disp('Verify started');
    out = image;
    if(containsWhite(image)==0) %Our image is all black, return
        return;
    end
    [X,Y] = size(image);
    
    closeMap = getCloseMap(image);
    disp('map generated');
    for x=1:X
        for y=1:Y
            %for each pixel
            if(image(x,y)==1) %If its white, we don't care 
                continue;
            end
            %If pixel is black, we need to prune
            %First, get information about the vector to our nearest pixel
            
            xloc=closeMap(x,y,1);
            yloc=closeMap(x,y,2);
            if(xloc == -1 && yloc==-1)
                out(x,y)=1;
                continue;
            end
            
            d=0;
            phi=0;
            Imax=uint8(1);
            %Now we de our calculation for each neighbouring pixel
            for xsub = -1:1
                for ysub = -1:1
                    %boundary
                    if(x+xsub < 1 || y+ysub<1 || x+xsub >= X || y+ysub >= Y)
                        continue;
                    end
                    
                    %vector information for nearest pixel
                    xloc2=closeMap(x+xsub,y+ysub,1);
                    yloc2=closeMap(x+xsub,y+ysub,2);

                    if(xloc2==-1 || yloc2==-1)
                        continue;
                    end
                    
                    dtemp = getDistance(xloc,yloc,xloc2,yloc2);
                    phitemp = getAngle(x,y,xloc,yloc,xloc2,yloc2);
                    I = original(xloc2,yloc2);
                    
                    %We keep the information if it is a maxima
                    d=max([d,dtemp]);
                    phi=max([phi,phitemp]);
                    Imax=max([I,Imax]);
                end
            end
            
            %Now we prune based on d and phi
            %These are pixel based pruning operations
            %disp(Imax/double(original(x,y)));
            %disp(double(Imax)/(double(original(x,y)+1)));
            if(d>MAXD || abs(phi) < MAXPHI || double(Imax)/(double(original(x,y)+1)) < CMIN)
                out(x,y)=1;
            end
        end
    end
    
    %Then we need to prune entire image based on connected component size
    [L,num] =bwlabel(imcomplement(out),4);
    count = zeros(num+1,1);
    for x =1:X
        for y=1:Y
            count(L(x,y)+1) = count(L(x,y)+1) + 1;
        end
    end
    
    %prune small sized parts
    for x =1:X
        for y=1:Y
            if (count(L(x,y)+1)<PSIZE)
                out(x,y)=1;
            end
        end
    end
end