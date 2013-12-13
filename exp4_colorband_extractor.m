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

%% Using LAB and a histogram of nbins take the largest bin
filt = fspecial('ave', 3);
for nbins = floor(linspace(1, 128, 16))
    for i = 1:lib_length
        imloc = sprintf('images/band_library/color%d.jpg', i-1);
        im = imread(imloc);

        % reshape the lab image into a vector
        im_lab = double(applycform(im, C_srgb2lab))/255;
        im_new = res_colorextract(im_lab, nbins, [1]);

        im_new_filt = res_colorextract(im_lab, nbins, filt);

        subplot(2,11,i);
        imshow(applycform(uint8(255*im_new), C_lab2srgb));
        title(sprintf('%s\n[%d]', lower(band_names{i}),i-1))

        subplot(2,11,i+11);
        imshow(applycform(uint8(255*im_new_filt), C_lab2srgb));

        title(sprintf('3x3 ave\n%s\n[%d]', lower(band_names{i}),i-1))
    end
    suptitle(sprintf('Extracted Color Bands using %d bins', nbins))
    name = sprintf('plots/exp4/extracted_%d_bins.png', nbins);    
    saveas(f, name,'png')    %library{i} = Ucov;
end