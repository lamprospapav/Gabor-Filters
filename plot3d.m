% load('gabor3d1.mat');
function plot3d(k,images,gabor3dResultTrain,gabor2dTrain)

figure(1)
imagesc(images(:,:,k));

gabor3d1 = zeros(10,10,24);
for i=1:24
    gabor3d1(:,:,i) = gabor3dResultTrain{k,i}(:,:);
end

figure(2)
for i=1:4
    for j=1:6
    subplot(4, 6, ((i-1)*6) + j);
    imagesc(gabor3d1(:,:,(i-1)*6 + j));
    end
end

gabor2d1 = gabor2dTrain{k,1};

figure(3)
for i=1:8
    subplot(1, 8, i);
    imagesc(gabor2d1(:,:,i));
    axis square;
end

end