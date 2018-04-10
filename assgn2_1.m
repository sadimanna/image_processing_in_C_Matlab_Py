%%
% _*Assignment-2*_
%
% *Question-1*
%
% *Get the 8-bit image ‘Tagore_Gandhi’. Add 128 to each of its pixels and
% show the resultant image and its histogram. Equalize the image using the
% approach of histogram equalization. Repeat the same procedure after
% multiplying each of its pixels by a factor of 2. Finally make one
% comparison between these two approaches*
% 
% _*Code*_ ::
%
tgimg = rgb2gray(imread('Tagore_Gandhi.jpg'));
stg = size(tgimg);

%Adding 128 to each pixel
tg128 = tgimg + 128;
%Part B
%tg128 = 2*(tgimg);

%Calculating the histogram
htg128 = zeros(1,256);
for pv=0:255
    htg128(pv+1) = nnz(tg128==pv);
end

%Visualizing the Histograms
subplot(221);
histogram(tg128,256)
title('In-built histogram')
subplot(222)
bar(0:1:255,htg128,'FaceColor','c','EdgeColor','k')
xlim([0 300])
title('Manual Histogram')

%Normalizing the Histogram
htgnorm = htg128/(stg(1)*stg(2));

%Histogram Equalization

%Mapping intensity values in original image to values in equalized image
bineq = zeros(1,256);
for pv=1:256
    bineq(pv) = uint8(255*sum(htgnorm(1:pv)));
end

%Constructing the equalized Histogram
htgeq = zeros(1,256);
for pv=1:256
    htgeq(pv) = sum(htg128(bineq == pv-1));
end

%Visualizing the equalized Histograms
subplot(223)
histogram(histeq(tg128,256),256)
title('In-built histeq histogram')
subplot(224)
bar(0:1:255,htgeq,'FaceColor','c','EdgeColor','k')
xlim([0 300])
title('Manual Histogram Equalization')

%Image from equalized histogram
eqimg = uint8(bineq(tg128+1));

%Visualizing the images
figure
subplot(221)
imshow(tgimg)
title('Original Image')
subplot(222)
imshow(tg128)
title('Adding 128 to each Pixel')
subplot(223)
imshow(histeq(tg128,256))
title('In-built function histeq Result')
subplot(224)
imshow(eqimg)
title('Manually equalized Image')

