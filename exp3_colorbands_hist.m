%% Form library
% Define the length of the library
lib_length = 11;
library = cell(lib_length,1); % first col is image second is
band_names = {'black', 'brown', 'red', 'orange', 'yellow', 'green', ...
     'blue', 'violet', 'gray', 'white', 'gold'};

%% Specify color transform
C_srgb2lab = makecform('srgb2lab');
C_lab2srgb = makecform('lab2srgb');

%% define figure
f = figure('units','normalized','outerposition',[0 0 1 1]);
%% save and plot color, HSV histograms and LAB histograms
for i = 1:lib_length
    imloc = sprintf('images/band_library/color%d.jpg', i-1);
    im = imread(imloc);
    
    im_lab = applycform(im, C_srgb2lab);
    im_hsv = rgb2hsv(im);
    subplot(1,1,1)
    imshow(im)
    title(sprintf('RGB Image for %s', band_names{i}))
    name = sprintf('plots/exp3/%d_%s_color.png', i, band_names{i});    
    saveas(f,name,'png')    %library{i} = Ucov;
    
    % plot HSV histograms and images
    im = im_hsv;
    subplot(3,2,1)
    hist(reshape(im(:,:,1),[],1),12)
    title(sprintf('Hue Histogram for %s', band_names{i}))

    subplot(3,2,2)
    imshow(im(:,:,1))
    title(sprintf('Hue Image for %s', band_names{i}))

    subplot(3,2,3)
    hist(reshape(im(:,:,2),[],1),12)
    title(sprintf('Saturation Histogram for %s', band_names{i}))

    subplot(3,2,4)
    imshow(im(:,:,3))
    title(sprintf('Saturation Image for %s', band_names{i}))

    subplot(3,2,5)
    hist(reshape(im(:,:,3),[],1),12)
    title(sprintf('Value Histogram for %s', band_names{i}))

    subplot(3,2,6)
    imshow(im(:,:,3))
    title(sprintf('Value Image for %s', band_names{i}))
    suptitle(sprintf('HSV Histograms and Images for %s', band_names{i}))

%    print(f, 
    name = sprintf('plots/exp3/%d_%s_hsv_hist.png', i, band_names{i});    

    saveas(f,name,'png')    %library{i} = Ucov;

    % plot LAB histograms and images
    im = double(im_lab)/255;
    subplot(3,2,1)
    hist(reshape(im(:,:,1),[],1),12)
    title(sprintf('L Histogram for %s', band_names{i}))

    subplot(3,2,2)
    imshow(im(:,:,1))
    title(sprintf('L Image for %s', band_names{i}))

    subplot(3,2,3)
    hist(reshape(im(:,:,2),[],1),12)
    title(sprintf('a Histogram for %s', band_names{i}))

    subplot(3,2,4)
    imshow(im(:,:,3))
    title(sprintf('a Image for %s', band_names{i}))

    subplot(3,2,5)
    hist(reshape(im(:,:,3),[],1),12)
    title(sprintf('b Histogram for %s', band_names{i}))

    subplot(3,2,6)
    imshow(im(:,:,3))
    title(sprintf('b Image for %s', band_names{i}))

    suptitle(sprintf('Lab Histograms and Images for %s', band_names{i}))

%    print(f, 
    name = sprintf('plots/exp3/%d_%s_lab_hist.png', i, band_names{i});    

    saveas(f,name,'png')    %library{i} = Ucov;

end

