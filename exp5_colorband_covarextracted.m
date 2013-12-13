%% Form library
% Define the length of the library
lib_length = 10;
library = cell(lib_length,1); % first col is image second is
library_mean = cell(lib_length,1); % first col is image second is

band_names = {...
                'black', 'brown', 'red', 'orange', 'yellow', 'green', ...
                'blue', 'violet', 'gray', 'white'... %, 'gold'...
             };
%% Specify color transform
C_srgb2lab = makecform('srgb2lab');
C_lab2srgb = makecform('lab2srgb');
filt = fspecial('ave', 4);

%%
nbins = 21;
for i = 1:lib_length
    imloc = sprintf('images/band_library/color%d.jpg', i-1);
    im_raw = imread(imloc);

    im_lab = double(applycform(im_raw, C_srgb2lab))/255;
    cov = res_colorextractcovar(im_lab,nbins, filt);
    
    subplot(2,10,i)
    extracted = res_colorextract(im_lab, nbins, filt);
    imshow(applycform(uint8(255*extracted), C_lab2srgb))
    title(sprintf('%d', i-1))
    library{i} = cov;

    library_mean{i} = [mean(mean(extracted(:,:,1))) mean(mean(extracted(:,:,2))) mean(mean(extracted(:,:,3)))];
end


%%
load('68k_0.jpg.mat')
bands = cell(4,1);
bands{1} = band4;
bands{2} = band3;
bands{3} = band2;
bands{4} = band1;
for k = 1:3
    %test_img = imread(sprintf('images/manual_extracted_bands/560k/band%d.jpg', k -1));
    test_img = bands{k};
    test_lab = double(applycform(test_img, C_srgb2lab))/255;
    extracted = res_colorextract(test_lab, nbins, filt);
    subplot(2,3,3 + k)
    imshow(applycform(uint8(255*extracted),C_lab2srgb))
    
    test_img_Ucov = res_colorextractcovar(test_lab, nbins, filt);

    distances = zeros(lib_length,1);
    distances_mean = zeros(lib_length,1);
    distances_dE94 = zeros(lib_length,1);

    coords = [mean(mean(extracted(:,:,1))) mean(mean(extracted(:,:,2))) mean(mean(extracted(:,:,3)))];

    for i = 1:lib_length
        distances(i) = dist_logeuc(library{i}, test_img_Ucov);
        distances_mean(i) = sqrt(sum((library_mean{i} - coords).^2));
        distances_dE94(i) = res_dist_dE94(library_mean{i}, coords);
    end
    
    %     distances
    [m i] = min(distances);
    arr  = mean(mean(test_lab(:,:,1)));
    [m_m i_m] = min(distances_mean);
    [m1_m i1_m] = min(distances_dE94);
    if k ~= 3
        title(sprintf('Covar: %d\nEuclidian Dist: %d\ndE94 Dist: %d',i-1,i_m-1, i1_m-1)) 
    else
        title(sprintf('Covar: 10^{%d}\nEuclidian Dist: 10^{%d}\ndE94 Dist: 10^{%d}',i-1,i_m-1, i1_m-1)) 
    
    end
     %     disp(i-1);
%     distances(i) = Inf;
%     [m i] = min(distances);
%     disp(i-1);
end

