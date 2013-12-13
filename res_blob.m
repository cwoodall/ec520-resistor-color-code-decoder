% find the thresholded saturation blob corisponding to the location of the
% resistor.

function im = res_blob(image,thresh)
    [x y] = size(image);
    resistor_hsv = rgb2hsv(image);
    resistor_sat = resistor_hsv(:,:,2);
    [hight,length] = size(resistor_sat);
    for i = 1:hight
        for j = 1:length
            if resistor_sat(i,j) > thresh
                resistor_sat(i,j) = 1;
            else
                resistor_sat(i,j) = 0;
            end
        end
    end
    im = medfilt2(resistor_sat,[16,16]);
end

