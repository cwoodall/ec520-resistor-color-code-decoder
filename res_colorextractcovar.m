function [ Ucov ] = res_colorextractcovar( im, nbins, filt )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    extracted = res_colorextract(im, nbins, filt);
    [nX nY nZ] = size( extracted );
    U = [];
    p = 1;
    for i = 1:nX
       for j = 1:nY
           for k = 1:nZ-1
               U(k,p) = extracted(i,j,k+1);
           end
           p = p + 1;
       end
    end
    
    Ucov = nancov(U');
end
