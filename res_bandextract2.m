function band_array = res_bandextract2(path,debug)

    %path = 'images/10_4.jpg';
    %% get standardized image
    % I import the image and call res_standardize. This doesn't really work for
    % images in the /cropped folder and it takes like 30 seconds for images in
    % the normal folder. manual cropping of the non-downsampled images would
    % fix this
    % get the resistor name
    namestart = find(path=='/');
    namestart = namestart(end);
    nameend = find(path=='.');
    name = path(namestart+1:nameend-1);

    % if the .mat file already exisits, load it, otherwise generate it
    if ~exist(cat(2,name,'_standard.mat'),'file')
        % standardize the image
        resistor = imread(path);
        resistor = imresize(resistor,.2);
        standard = res_standardize(resistor,0.25,-0.15,-0.2,name);

        % save the standardized image
        save(cat(2,name,'_standard.mat'),'standard');
    else
        load(cat(2,name,'_standard.mat'))
    end

    %% show basics
    % we start by showing the standardized image of the resistor and the
    % saturation of that image
    r = 4;
    [x,y] = size(standard);
%    standard_hsv = double(applycform(standard, C))/255;
 %   filt = fspecial('ave', 3); % filter
%     standard_hsv = rgb2hsv(standard);
%     standard_hsv(:,:,3) = histeq(standard_hsv(:,:,3));
        %standard_hsv(:,:,3) = histeq(standard_hsv(:,:,3));
    newRange = 1.3;
    image = double(standard)/255;
    imgMin = double(min(image(:)))

    imgMax = double(max(image(:)))
    image = (image - imgMin) / (imgMax - imgMin) * newRange
    imshow(image)
    %colormap(ctmap);
    
    
    figure()
%     standard = hsv2rgb(standard_hsv);
%     standard_hsv(:,:,1) = abs(double(standard(:,:,1))/255 - median(median(double(standard(:,:,1))/255)));
%     standard_hsv(:,:,2) = abs(double(standard(:,:,2))/255 - median(median(double(standard(:,:,2))/255)));
%     standard_hsv(:,:,3) = abs(double(standard(:,:,3))/255 - median(median(double(standard(:,:,3))/255)));
%     standard_gray = rgb2gray(standard_hsv);
    if debug
%         subplot(4,1,1);
%         imshow(standard_gray);
%         title('color');
% 
%         subplot(4,2,3);
%         %imshow(standard_hsv(:,:,1));
%         imshow(standard_gray)
%         title('hue');
%         
%          subplot(4,2,4);
%          title('hue');
%          plot(mean(standard_gray));
% 
%          % 
% %         subplot(4,2,5);
% %         imshow(standard_hsv(:,:,2));
% %         title('saturation');
% % 
% %         subplot(4,2,6);
% %         hist(reshape(standard_hsv(:,:,2),1,[]));
% %         title('saturation');
% % 
% %         
% %         subplot(4,2,7);
% %         imshow(standard_hsv(:,:,3));
% %         title('value');
% % 
% %         
% %         subplot(4,2,8);
% %         hist(reshape(standard_hsv(:,:,3),1,[]));
% %         title('value');
% %        
        
    end
    

    %% show the bands
    % I take the vector I find the first 8 times the vector goes from 0 to 1 as
    % i itterate through it. I say these numbers define the start and stop
    % points of the bands
    x = length(med_edge);
    final_band = ones(1,8);
    count = 0;
    in_band = 0;
    j = 1;
    for i = 1:x-1
        if (med_edge(i+1) >= 1) && (med_edge(i) == 0)
            in_band = ~in_band;
            hold on;
             % this is an awful fix. The extracted colors were coming out a
            % little offset so i put a +6 here to fix it. I'm sorry
            final_band(j) = i+4;
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

        if count > 26
            final_band(j) = i+6;
            j = j + 1;
            in_band = ~in_band;
        end
    end
    
    band1 = standard(:,final_band(1):final_band(2),:);
    band2 = standard(:,final_band(3):final_band(4),:);
    band3 = standard(:,final_band(5):final_band(6),:);
    band4 = standard(:,final_band(7):final_band(8),:);
    
    if debug
        subplot(r,4,29);
        imshow(band1);
        subplot(r,4,30);
        imshow(band2);
        subplot(r,4,31);
        imshow(band3);
        subplot(r,4,32);
        imshow(band4);
    end
    %save(cat(2,name,'_bands.mat'),'band1','band2','band3','band4');
    
    band_array = {band1,band2,band3,band4};
end

