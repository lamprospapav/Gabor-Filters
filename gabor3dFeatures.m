function gabor3dResult = gabor3dFeatures(img,gabor3dArray)

%% Filtering

% Filter input image by each Gabor filter
[u,v] = size(gabor3dArray);
gabor3dResult = cell(u,v);

for i = 1:u
    for j = 1:v
        gabor3dResult{i,j} = zeros(size(img,1), size(img,2));
        for k=1:size(img,3)
            gabor3dResult{i,j} = gabor3dResult{i,j} + conv2(img(:,:,k),gabor3dArray{i,j}(:,:,k),'same');
        end
        gabor3dResult{i,j} = abs(gabor3dResult{i,j});
%         temp=max(max(gabor3dResult{i,j}));
%         gabor3dResult{i,j}=(gabor3dResult{i,j}).^2;
    end
end


end