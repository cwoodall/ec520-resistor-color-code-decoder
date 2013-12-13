% Form library
% Define the length of the library
lib_length = 11;
library = cell(lib_length,1); % first col is image second is
band_names = {'black', 'brown', 'red', 'orange', 'yellow', 'green', ...
     'blue', 'violet', 'gray', 'white', 'gold'};

for i = 1:lib_length
    imloc = sprintf('images/band_library/color%d.jpg', i-1);
    im = imread(imloc);

    %im(:,:,1) = histeq(im(:,:,1));
    %im(:,:,2) = histeq(im(:,:,2));
    %im(:,:,3) = histeq(im(:,:,3));

    mean(mean(im(:,:,1)))
    U = rgb2xyhsv(im);
    Ucov = nancov(U');
%     Ucov(1,1) = 0;
%     Ucov(2,2) = 0;
    library{i} = Ucov;
end

test_img = imread('images/manual_extracted_bands/1k/band0.jpg');
%test_img(:,:,1) = histeq(test_img(:,:,1));
%test_img(:,:,2) = histeq(test_img(:,:,2));
%test_img(:,:,3) = histeq(test_img(:,:,3));
mean(mean(im(:,:,1)))

imshow(test_img(:,:,1))
h = rgb2hsv(test_img);
test_img_U = rgb2xyhsv(test_img);
test_img_cov = nancov(test_img_U');
% test_image_cov(1,1) = 0;
% test_image_cov(2,2) = 0;

distances = zeros(lib_length,1);
for i = 1:lib_length
    distances(i) = dist_logeuc(library{i}, test_img_cov);
end
distances
[m i] = min(distances);
disp(i-1);
distances(i) = Inf;
[m i] = min(distances);
disp(i-1);

