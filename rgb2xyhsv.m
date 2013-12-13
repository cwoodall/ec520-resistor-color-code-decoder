function [M] = rgb2xyhsv( IM )
%COVAR Summary of this function goes here
%   Detailed explanation goes here
    [X Y Z] = size(IM);
%     IM = rgb2hsv(IM);
% 
%    colorTransform = makecform('srgb2lab');
%    IM = applycform(IM, colorTransform);
    IM = rgb2hsv(IM);
    f = fspecial('gaus', [3,3]);
    IM(:,:,1) = filter2(f,IM(:,:,1));
    IM(:,:,2) = filter2(f,IM(:,:,2));
    IM(:,:,3) = filter2(f,IM(:,:,3));
    figure()
    imshow(IM)
    %figure()
    %subplot(1,3,1)
    %imshow(IM(:,:,1))
     %   subplot(1,3,2)

    %imshow(IM(:,:,2))
    %subplot(1,3,3)

   % imshow(IM(:,:,3))
    M = [];
    p = 1;
    for i = 1:X
        for j = 1:Y
       %     if ((IM(i,j,3) < .95) && (IM(i,j,3) > .05))
         %      M(1,p) = i-1;
         %      M(2,p) = j-1;
               M(1,p) = IM(i,j,1);
               M(2,p) = IM(i,j,2);
               M(3,p) = IM(i,j,3);
               p = p + 1;
           end
       % end
    end
    %M
end

