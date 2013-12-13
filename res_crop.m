function [top bottom left right] = res_crop(blob,x_margin,y_margin)
    debug = 0;
    [x,y] = res_find(blob);
    [hight length] = size(blob);
    top = x;
    bottom = x;
    left = y;
    right = y;
    for i = 1:hight
        for j = 1:length
            if (blob(i,j) == 1)
                if i < top
                    top = i;
                end
                if i > bottom
                    bottom = i;
                end
                if j < left
                    left = j;
                end
                if j > right
                    right = j;
                end
            end
        end
    end
    res_length = right-left;
    res_hight = bottom - top;
    
    if debug
        fprintf('Resistor Dimentions = [t = %d,b = %d,l = %d,r = %d]\n',top,bottom,left,right);
    end
    
    top    = top    - (floor(res_hight *x_margin));
    bottom = bottom + (floor(res_hight *x_margin));
    left   = left   - (floor(res_length*y_margin));
    right  = right  + (floor(res_length*y_margin));
    
    if top < 1
        top = 1;
    end
    
    if bottom < 1
        bottom = 1;
    end
    
    if left < 1
        left = 1;
    end
    
    if right < 1
        right = 1;
    end
    
    if debug
        fprintf('Cropping dimentions = [t = %d,b = %d,l = %d,r = %d]\n',top,bottom,left,right);
    end
end

