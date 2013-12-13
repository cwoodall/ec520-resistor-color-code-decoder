function standardized_image = res_standardize(image,threshold,x_margin,y_margin,name)
    % find the resistor and crop it down to a smaller size
    blob = res_blob(image,threshold);
    figure(1)
    imshow(blob);
    % find the angle of the resistor
    angle = res_rotate(blob);

    % rotate the cropped image
    rot = imrotate(image,angle);

    % crop the rotated image the rest of the way
    rot_im = res_blob(rot,threshold);
    [t b l r] = res_crop(rot_im,x_margin,y_margin);
    
    % filter vertically to clear out horizontal signals
    fir = [0 0 3 0 0;
           0 0 3 0 0;
           0 0 3 0 0;
           0 0 3 0 0;
           0 0 3 0 0]/(1*(15));
        
    for i = 1:3
        rot(:,:,i) = filter2(fir, rot(:,:,i));
    end
    
    % return the cropped image
    standardized_image = rot(t:b,l:r,:);
end

