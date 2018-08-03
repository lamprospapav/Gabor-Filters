function plot_3d_filter_k_l(k,l,gabor3dbank)
figure(4)
k=1;
l=1;
for i=1:8
    subplot(1, 8, i);
    imagesc(gabor3dbank{k,l}(:,:,i)); 
    colormap gray
    axis square;
end
end