function [ label ] = res_knn_classifer( extracted_band, library, distMetric, k)
%res_knn_classifer runs a knn classifier finding the k nearest neighbor
%                  for the band in the library. 
%   band should be a single point in L*a*b* space and the library should
%   be a cellarray of the 11 color bands (or 10 if gold is excluded.
%   FIXME: k must be 1.
%   
%   Uses the distance metric specified by distMetric to find the distance.
%
%   Returns the label in library that the band has been classified as.

    k = 1;
    
    % Get the mean L*a*b* coordinate of the band.
    bandCoords = reshape(mean(mean(extracted_band)),1,3);
    
    distances = [];
    labels = [];
    for label_idx = 1:numel(library)
        lab = library{label_idx};
        [points_N, coords_N] = size(lab);
        for point_idx = 1:points_N
            dist = distMetric(bandCoords, lab(point_idx,:));
            distances = [distances dist];
            labels = [labels label_idx];
        end
    end
    %labels
    [min_val min_idx] = min(distances);
    label = labels(min_idx);
end

