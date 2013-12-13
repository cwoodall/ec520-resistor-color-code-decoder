%%

figure(1);

%%
subplot(3,4,1);
resistor1 = imread('images/560k_3.jpg');
imshow(resistor1);

subplot(3,4,5);
hold on;
blob1 = res_blob(resistor1,0.25);
imshow(blob1);
[x1 y1] = res_find(blob1);
plot(y1,x1,'rx')
angle1 = res_rotate(blob1);
sangle = sprintf('angle = %d',angle1);
title(sangle);

subplot(3,4,9);
standard1 = res_standardize(resistor1,0.25,-0.25,-0.1);
imshow(standard1);
%%
subplot(3,4,2);
resistor2 = imread('images/620k_3.jpg');
imshow(resistor2);

subplot(3,4,6);
hold on;
blob2 = res_blob(resistor2,0.25);
imshow(blob2);
[x2 y2] = res_find(blob2);
plot(y2,x2,'rx')
angle2 = res_rotate(blob2);
sangle = sprintf('angle = %d',angle2);
title(sangle);

subplot(3,4,10);
standard2 = res_standardize(resistor2,0.25,-0.25,-0.1);
imshow(standard2);
%%

subplot(3,4,3);
resistor3 = imread('images/560k_4.jpg');
imshow(resistor3);

subplot(3,4,7);
hold on;
blob3 = res_blob(resistor3,0.25);
imshow(blob3);
[x3 y3] = res_find(blob3);
plot(y3,x3,'rx')
angle3 = res_rotate(blob3);
sangle = sprintf('angle = %d',angle3);
title(sangle);

subplot(3,4,11);
standard3 = res_standardize(resistor3,0.25,-0.25,-0.1);
imshow(standard3);
%%

subplot(3,4,4);
resistor4 = imread('images/100k_1.jpg');
imshow(resistor4);

subplot(3,4,8);
hold on;
blob4 = res_blob(resistor4,0.25);
imshow(blob4);
[x4 y4] = res_find(blob4);
plot(y4,x4,'rx')
angle4 = res_rotate(blob4);
sangle = sprintf('angle = %d',angle4);
title(sangle);

subplot(3,4,12);
standard4 = res_standardize(resistor4,0.25,-0.25,-0.1);
imshow(standard4);