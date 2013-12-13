function [ dE ] = res_dist_dE94( p1, p2 )
%res_dist_dE94 Takes the CIE94 deltaE distance between p1 and p2
%   Algorithm taken from:
%   http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE94.html

    da = p1(2) - p2(2);
    db = p1(3) - p2(3);
    dL = p1(1) - p2(1);
    C_1 = sqrt(p1(2)^2 + p1(3)^2);
    C_2 = sqrt(p2(2)^2 + p2(3)^2);
    
    dC = C_1 - C_2;
    dH = sqrt(da^2 + db^2 - dC^2);
    
    K_L = 1;
    K_C = 1;
    K_H = 1;
    K_1 = .045;
    K_2 = .015;
    
    S_L = 1;
    S_C = 1 + K_1*C_1;
    S_H = 1 + K_2 * C_1;
    
    dE = sqrt((dL/(K_L*S_L))^2 + (dC/(K_C*S_C))^2 + (dH/(K_H*S_H))^2);
end

