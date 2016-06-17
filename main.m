function main
    global MAXD; %Max thickness for vessels
    global TSTART; %Minimum threshold of grey ness
    global TEND; %Maximum threshold
    global MAXPHI; %Maximim angle (phi) for vessel
    global PSIZE; %Minimum size for connected component
    global CMIN; %Minimum contrast for component
    MAXD = 9; 
    TSTART=0.3;
    TEND=0.8;
    PSIZE=44; 
    MAXPHI = 140;
    CMIN=1.07;   
    
    iterations=45;
    
    im=imread('retina_small.tif','tif');
    green = im(:,:,2); % 1 for red 2 green and 3 blue
    im=green;
    
    imwrite(uint8(im),'Image.tiff','tiff','Compression','none');

    output = runEach(iterations,im);
    imwrite(uint8(output)*255,strcat('result_image.tiff'),'tiff','Compression','none')
    imshow(output);
    
end