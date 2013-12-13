%% Form library
% Define the length of the library
lib_length = 11; %Exclude the last band for now
library = cell(lib_length,1); % Coordinates
library_mean = cell(lib_length,1); % first col is image second is

band_names = {...
                'black', 'brown', 'red', 'orange', 'yellow', 'green', ...
                'blue', 'violet', 'gray', 'white', 'gold'...
             };
         

scatter_colors = {...
                [0 0 0], [.5 .2 0], [1 0 0], [1 .5 0], [1 1 0], [0 1 0], ...
                [0 0 1], [1 0 1], [.5 .5 .5], [.9 .9 .9], [.93 .84 .61] ... %, 'gold'...
             };
%% Specify color transform
C_srgb2lab = makecform('srgb2lab');
C_lab2srgb = makecform('lab2srgb');

%% Specify the Averaging filter for color extraction and the number of bins
filt = fspecial('ave', 3); % filter

%% Form a labeled library of points

nbins = 24; % number of bins

scat_fig = figure();
%extract_fig = figure();

for color_idx = 1:lib_length
    for sample_idx = 1:10

        imloc = sprintf('images/band_library/color%d_%d.jpg',...
                        color_idx-1, sample_idx);

        if exist(imloc, 'file') == 2
            im_raw = imread(imloc);

            im_lab = double(applycform(im_raw, C_srgb2lab))/255;

            %subplot(2,10, color_idx)
            extracted = res_colorextract(im_lab, nbins, filt);
          %  imshow(applycform(uint8(255*extracted), C_lab2srgb))
           % title(sprintf('%d', i-1))
            Lab_coord = [mean(mean(extracted(:,:,1))) mean(mean(extracted(:,:,2))) mean(mean(extracted(:,:,3)))];
            scatter3(Lab_coord(1), Lab_coord(2), Lab_coord(3), 50,scatter_colors{color_idx}, 'filled')
            xlabel('L*')
            ylabel('a*')
            zlabel('b*')

            library{color_idx} = [library{color_idx}; Lab_coord];
            hold on
        end
    end
end

save('color_library.mat', 'library')

%%
%distMetric = @(p1, p2) res_dist_dE94(p1, p2);
distMetric = @(p1, p2) sqrt(sum((p2 - p1).^2));
%load('360_0.jpg.mat')
%bands = cell(4,1);
extract_fig = figure();
bands = res_bandextract2('images/test/test2.jpg', 1);
% bands{1} = band1;
% bands{2} = band2;
% bands{3} = band3;
% bands{4} = band4;
color_fig = figure();
%%
for k = 1:4
    %test_img = imread(sprintf('images/manual_extracted_bands/2_2k/band%d.jpg', k-1));
    test_img = bands{k};
    test_lab = double(applycform(test_img, C_srgb2lab))/255;
    extracted = res_colorextract(test_lab, nbins, filt);
    bandCoords = reshape(mean(mean(extracted)),1,3);
    
    figure(scat_fig)
    scatter3(bandCoords(1), bandCoords(2), bandCoords(3), 200, 'kX')
    text(bandCoords(1)+.01,bandCoords(2)+.02,bandCoords(3),sprintf('%d', k),...
         'color',[0 0 0]);
    figure(color_fig)
    subplot(1,4,k)
    imshow(applycform(uint8(255*extracted),C_lab2srgb))
    
    label = res_knn_classifer(extracted, library, distMetric, 1);
    
    if k ~= 3
        title(sprintf('%d',label-1)) 
    else
        title(sprintf('10^{%d}',label-1)) 
    
    end
end




