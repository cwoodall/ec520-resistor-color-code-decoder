fir0 = [0 0 0 0 0;
        0 0 0 0 0;
        1 2 3 2 1;
        0 0 0 0 0;
        0 0 0 0 0]/(1*(9));

fir1 = [0 0 0 0 1;
        0 0 0 2 0;
        0 0 3 0 0;
        0 2 0 0 0;
        1 0 0 0 0]/(1*(9));

fir2 = [0 0 1 0 0;
        0 0 2 0 0;
        0 0 3 0 0;
        0 0 2 0 0;
        0 0 1 0 0]/(1*(9));

exp1_center_detect('images/cropped/560k_3.jpg',1,fir1,0.5,2);
exp1_center_detect('images/cropped/560k_3.jpg',2,fir1,0.5,1);
exp1_center_detect('images/cropped/560k_3.jpg',3,fir1,0.5,3);
exp1_center_detect('images/cropped/560k_3.jpg',4,fir1,0.25,2);
exp1_center_detect('images/cropped/560k_3.jpg',5,fir1,0.25,1);
exp1_center_detect('images/cropped/560k_3.jpg',6,fir1,0.25,3);
