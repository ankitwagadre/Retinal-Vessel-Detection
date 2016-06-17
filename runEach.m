function output= runEach(iterations,im)
    global TEND;
    global TSTART;
    
    [X,Y,Z] = size(im);
    output = zeros(X,Y);
    jmp = double((TEND-TSTART))/double(iterations);
    for i=0:iterations
        cur = TSTART + double(jmp) * double(i);
        temp = im2bw(im, cur);
        temp = verify(temp,im);
               
        %(imcomplement) black became white white became black 
        temp = imcomplement(temp);
        output = output | temp;
        imwrite(uint8(output)*255,strcat(num2str(i),'partial.tiff'),'tiff','Compression','none');
    end
    output = imcomplement(output);
end
