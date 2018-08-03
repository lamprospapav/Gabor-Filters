function [result, gabor2d, gabor3dResult]  = convolution_2d_3d(image, gaborFilters, gabor3dArray)
	
    gabor2d = featureVector(image, gaborFilters, 2, 2);
    
    maxPooledImage = zeros(size(gabor2d,1)/2, size(gabor2d,2)/2, size(gabor2d,3));
    for j=1:size(gabor2d,3)
        maxPooledImage(:,:,j) = maxPool(gabor2d(:,:,j),2,2);
    end    
    
    gabor3dResult = gabor3dFeatures(maxPooledImage,gabor3dArray);
    gabor3dResult = gabor3dResult(:);
    
    maxPooledImage = cell(size(gabor3dResult,1),1);
    for i=1:size(gabor3dResult,1)
        maxPooledImage{i,1} = zeros(size(maxPooledImage{i,1},1)/2, size(maxPooledImage{i,1},1)/2, size(gabor3dResult{i,1},3));
        for j=1:size(gabor3dResult{1,1},3)
            maxPooledImage{i,1}(:,:,j) = maxPool(gabor3dResult{i,1}(:,:,j),2,2);
        end
    end
    
    result = maxPooledImage;
    
end
