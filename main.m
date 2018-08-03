clear all
close all
tic

% load image set
load('images.mat');
images = images(:,:,:)./255;

% load('labels.mat');

% gabor2dTrain = cell(60000,1);
% gabor3dResultTrain = cell(60000,60);

% tmp1 = zeros(20,20,8);
% tmp2 = cell(60,1);

% Make gabor filters bank
gaborFiltersBank = gaborFilterBankNikos(1,8,9,9,0,0.5,0.8,0);
%     gaborFiltersBank = gaborFilterBank(1,8,7,7);
gaborFilters = zeros(9,9,8);
for i=1:8
    gaborFilters(:,:,i) = gaborFiltersBank{1,i};
end

gabor3dArray = gabor3dBankFilters;

input_train = zeros(60000,1750);

parfor i=1:size(images,3)
    
    [result, tmp1, tmp2] = convolution_2d_3d(images(:,:,i),gaborFilters, gabor3dArray);  
%     [result, ~, ~] = convolution_2d_3d(images(:,:,i),gaborFilters, gabor3dArray);
    
%     gabor2dTrain{i,1} = tmp1;
    
    r = [];
    for j=1:70
%         gabor3dResultTrain{i,j} = tmp2{j,1};
        r = [r; result{j,1}(:)]; 
    end
    input_train(i,:) = r';
    
%     plot3d(i,images,gabor3dResultTrain,gabor2dTrain);
end
% clear tmp1 tmp2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('images_test.mat');
images_test = images_test(:,:,:)./255;

% load('labels_test.mat');



% gabor2dTest = cell(10000,1);
% gabor3dResultTest = cell(10000,60);

% tmp1 = zeros(20,20,8);
% tmp2 = cell(60,1);

input_test = zeros(10000,1750);

parfor i=1:size(images_test,3)

%     [result, tmp1, tmp2] = convolution_2d_3d(images_test(:,:,i),gaborFilters, gabor3dArray);
    [result, ~, ~] = convolution_2d_3d(images_test(:,:,i), gaborFilters, gabor3dArray);
    
%     gabor2dTest{i,1} = tmp1;
    
    r = [];
    for j=1:70
%         gabor3dResultTest{i,j} = tmp2{j,1};
        r = [r; result{j,1}(:)]; 
    end
    input_test(i,:) = r';
    
%     plot3d(i,images,gabor3dResultTest,gabor2dTest);
end

% clear tmp1 tmp2;

clear images images_test i gaborFiltersBank
load('labels.mat');
load('labels_test.mat');

train_nn_exp_2;

toc
% figure
% for i=1:6
%     for j=1:6
%         subplot(6, 6, (i-1)*6 + j);
%         imagesc(result{(i-1)*6+j,1});
%         colormap gray
%     end
% end