% Find the angle offset of the resistor blob from horizontal

function angle = res_rotate(blob)
    debug = 0;
    [x y] = res_find(blob);
    [hight length] = size(blob);
    hypotenuse = 0;
    if (debug)
        figure(2);
        hold off;
        imshow(cropped_blob);
        hold on;
        plot(y,x,'rx');
    end
    for i = 1:hight
        for j = 1:length
            if blob(i,j) == 1
                d = pdist([x,y;i,j],'euclidean');
                if d > hypotenuse
                    hypotenuse = d;
                    x_farthest_point = i;
                    y_farthest_point = j;
                    if debug
                        plot(y_farthest_point,x_farthest_point,'g*');
                    end
                end
            end
        end
    end
    oposite = x_farthest_point-x;
    adjacent = y_farthest_point-y;
    angle = (180*atan(oposite/adjacent))/pi;
    if (debug)
        plot(y_farthest_point,x_farthest_point,'bo');
        fprintf('farthest point - [%d,%d]\n',y_farthest_point,x_farthest_point);
        fprintf('angle - %d\n',angle);
        fprintf('hypotenuse - %d\n',hypotenuse);
        fprintf('oposite - %d\n\n',oposite);
        fprintf('adjacent - %d\n\n',adjacent);
        figure(1);
    end
end