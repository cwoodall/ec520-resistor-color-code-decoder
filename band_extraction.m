%% Extract bands from a resistor image matlab
clear
%% get standardized image
% I import the image and call res_standardize. This doesn't really work for
% images in the /cropped folder and it takes like 30 seconds for images in
% the normal folder. manual cropping of the non-downsampled images would
% fix this
im = 'images/orig/180_0.jpg';
name = '180_0.jpg';
figure(3);
resistor = imread(im);
resistor = imresize(resistor,1);
standard = res_standardize(resistor,0.25,-0.25,-0.1,name);
% save the standardized image
save(cat(2,name,'_standard.mat'),'standard');

% need to add logic to check for the saved file so we don't have to run the
% standardization code every time
%% show basics
% we start by showing the standardized image of the resistor and the
% saturation of that image
r = 8;

[x,y] = size(standard);

subplot(r,1,1);
imshow(standard);
title('color');

standard_hsv = rgb2hsv(standard);
standard_hsv(:,:,2) = imadjust(standard_hsv(:,:,2),[.3 .8],[]);
subplot(r,1,2);
imshow(standard_hsv(:,:,2));
title('saturation');

%% edge detection
% nothing fancy here. just do a canny edge detection on the saturation of
% the image
subplot(r,1,3);
edges = edge( standard_hsv(:,:,2) ,'canny');
imshow(edges);
title('canny edge detection');
%% filtering nonsense
% this probably isn't the best way to go about this. I basicly widen the
% canny edges to merge edges that are too close, then median filter
% vertically to remove non vertical edges. Finally I widen these blobs
% vertically to make them more pronounced for the next step
subplot(r,1,4);
fir = ones(1,floor(y/100));
edges_merge = filter2(fir,edges);
imshow(edges_merge);
title('horizontal filtering');
subplot(r,1,5);
edges_streach_med = medfilt2(edges_merge,[x,1]);
imshow(edges_streach_med);
title('vertical median filter');
subplot(r,1,6);
fir = ones(floor(x/5),1);
edges_streach_filt = filter2(fir,edges_streach_med);
imshow(edges_streach_filt);
title('vertical filter again');
%% absolute edge detection from merged lines
% this takes the vertical blob pictures I spent all that time makeing and
% finds the median of each column.  This gives a binary vector with ones
% where i'm pretty sure there are vertical edges.
subplot(r,1,7);
med_edge = median(abs(edges_streach_filt));
imshow(med_edge);
title('med edges');
%% show the bands
% I take the vector I find the first 8 times the vector goes from 0 to 1 as
% i itterate through it. I say these numbers define the start and stop
% points of the bands
x = length(med_edge);
final_band = zeros(1,8);
count = 0;
in_band = 0;
j = 1;
for i = 14:x-1
    if (med_edge(i+1) >= 1) && (med_edge(i) == 0)
        in_band = ~in_band;
        
        % this is an awful fix. The extracted colors were coming out a
        % little offset so i put a +6 here to fix it. I'm sorry
        final_band(j) = i+6;
        j = j + 1;
        
        if j > 8
            break;
        end
    end
    
    % keep a count when we're traversing what we think is a band. bands
    % arn't long so if we go 24 pixles without another edge, we mised it
    % and we need to cut the extraction here
    if in_band
        count = count + 1;
    else
        count = 0;
    end
    
    if count > 25
        final_band(j) = i+6;
        j = j + 1;
        in_band = ~in_band;
    end
end
subplot(r,4,29);
band1 = standard(:,final_band(1):final_band(2),:);
imshow(band1);
subplot(r,4,30);
band2 = standard(:,final_band(3):final_band(4),:);
imshow(band2);
subplot(r,4,31);
band3 = standard(:,final_band(5):final_band(6),:);
imshow(band3);
subplot(r,4,32);
band4 = standard(:,final_band(7):final_band(8),:);
imshow(band4);
save(cat(2,name,'.mat'),'band1','band2','band3','band4');