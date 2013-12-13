function [x,y] = res_find(blob)
    debug = 0;
    [hight,length] = size(blob);
    x = 0;
    M = 0;
    for i = 1:hight
        x = x + (sum(blob(i,:))*i);
        M = M + sum(blob(i,:));
    end
    y = 0;
    M = 0;
    for i = 1:length
        y = y + (sum(blob(:,i))*i);
        M = M + sum(blob(:,i));
    end
    x = x/M;
    y = y/M;
    if debug
        fprintf('center - [%d,%d]\n',floor(x),floor(y));
    end
end