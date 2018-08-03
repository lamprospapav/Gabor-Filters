function featureVector = featureVector(image,gaborFilters,d1,d2)
%     featureVector = zeros( size(image,1), size(image,2), size(gaborFilters,3) );
    featureVector = zeros( 20, 20, size(gaborFilters,3) );
    featureVector(:,:,:) =  gaborFeatures(image,gaborFilters,d1,d2);
end