function exp1_center_detect(image,fig,fir,thresh,hsv)
    figure(fig);
    example_resistor = imread(image);
    example_resistor_hsv = rgb2hsv(example_resistor);
    [x,y] = size(example_resistor_hsv(:,:,hsv));
    subplot(1,3,1)

    imshow(filter2(fir, example_resistor_hsv(:,:,hsv)));
    switch hsv
        case 1
            title('hue values of image')
        case 2
            title('saturation values of image')
        case 3
            title('intensity values of image')
    end
    subplot(1,3,2)
    for i = 1:x
        for j = 1:y
            if example_resistor_hsv(i,j,hsv) > thresh
                example_resistor_hsv(i,j,hsv) = 1;
            else
                example_resistor_hsv(i,j,hsv) = 0;
            end
        end
    end
    imshow(example_resistor_hsv(:,:,hsv))
    t = sprintf('image thresholded at %d',thresh);
    title(t)
    subplot(1,3,3)
    hold off
    imshow(medfilt2(example_resistor_hsv(:,:,hsv),[3,3]));
    
    filt_im = medfilt2(example_resistor_hsv(:,:,hsv),[3,3]);
    [x,y] = size(filt_im);
    title('3x3 med filter w/ center of mass')
    x_cent = 0;
    M = 0;
    for i = 1:x
        x_cent = x_cent + (sum(filt_im(i,:))*i);
        M = M + sum(filt_im(i,:));
    end
    y_cent = 0;
    M = 0;
    for i = 1:y
        y_cent = y_cent + (sum(filt_im(:,i))*i);
        M = M + sum(filt_im(:,i));
    end
    x_cent = x_cent/M;
    y_cent = y_cent/M;
    
    fprintf('%d,%d\n',x_cent,y_cent);
    hold on
    plot(y_cent,x_cent,'rx')
    
end
