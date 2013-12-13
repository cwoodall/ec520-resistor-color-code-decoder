function exp0_edge_detect(image,fig,fir)
    figure(fig);
    example_resistor = imread(image);
    example_resistor_hsv = rgb2hsv(example_resistor);

    subplot(2,2,1)
    title(image);
    imshow(filter2(fir, example_resistor_hsv(:,:,2)));
    subplot(2,2,2)
    imshow(edge(filter2(fir, example_resistor_hsv(:,:,2)), 'canny', [.3 .58]));
    subplot(2,2,3)
    imshow(example_resistor_hsv(:,:,3));
    subplot(2,2,4)
    val_edges = edge(filter2(fir,example_resistor_hsv(:,:,3)), 'canny', [.1 .2]);
    imshow(val_edges);
end
