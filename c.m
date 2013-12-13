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

exp0_edge_detect('images/cropped/2_2k_0.jpg',1,fir0);
exp0_edge_detect('images/cropped/620k_1.jpg',2,fir1);
exp0_edge_detect('images/cropped/560k_1.jpg',3,fir1);
exp0_edge_detect('images/cropped/560k_3.jpg',4,fir1);
exp0_edge_detect('images/cropped/910_0.jpg' ,5,fir0);
exp0_edge_detect('images/cropped/620k_6.jpg',6,fir2);
