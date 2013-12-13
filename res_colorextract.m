function [ im_res ] = res_colorextract( im_lab, nbins, filt )
%RES_COLOREXTRACT Extract the color band using a histogramming method
%   Arguments:   
%       im_lab - an image in lab space
%       nbins  - number of histogram bins to use in extraction
%       filt   - a 2d filter which is applied to the resistor
%
%   Method:
%   1.   Turns each element of the Lab space image into a vector.
%   2.   Takes a histogram of nbins for the L component
%   3.   Find the bin withe most elements
%   4.   Extract all of the pixels which lie in that band
%   5.   Make a square image (throw away extras)
%   6.   Filter the square image using filt, only return "valid" pixels.
%   7.   Return im_res (filtered square image in Lab space)

    % Turn each element into a vector
    im_l = reshape(im_lab(:,:,1),[],1);
    im_a = reshape(im_lab(:,:,2),[],1);
    im_b = reshape(im_lab(:,:,3),[],1);
    

    % take a histogram of nbins
    [im_Lhist, im_Lcenters] = hist(im_l,nbins);
    
    % find the bin with the most luminances of the same type
    bin = find(im_Lhist == max(im_Lhist));
    
    % take that bin
    top = im_Lcenters(bin(1)) + (1/(2*nbins));
    bot = im_Lcenters(bin(1)) - (1/(2*nbins));
    indxs = find((im_l >= bot) & (im_l < top));

    % Remove some indexes so we can make a square image for display
    square_elems = floor(sqrt(numel(indxs)))^2;
    indxs = indxs(1:square_elems);
    
    x = sqrt(square_elems);

    imres_l = im_l(indxs);
    imres_a = im_a(indxs);
    imres_b = im_b(indxs);
    
    % reshape into a square 
    im_new = zeros(x,x,3);
    im_new(:,:,1) = reshape(imres_l,x,x);
    im_new(:,:,2) = reshape(imres_a,x,x);
    im_new(:,:,3) = reshape(imres_b,x,x);

    % Filter images and return valid pixels.
    im_new_filt_l = filter2(filt,im_new(:,:,1),'valid');
    im_new_filt_a = (filter2(filt,im_new(:,:,2),'valid'));
    im_new_filt_b = (filter2(filt,im_new(:,:,3),'valid'));

    % Form im_res to be returned
    im_res = zeros([size(im_new_filt_l) 3]);
    im_res(:,:,1) = im_new_filt_l;
    im_res(:,:,2) = im_new_filt_a;
    im_res(:,:,3) = im_new_filt_b;

end

