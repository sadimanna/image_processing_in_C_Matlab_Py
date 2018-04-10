%%
% *Assignment 3*
% 
% _Question 1_
%  
% *Median filtering*
%  1. Take an image and add noise to it.
%  2. Write a code to implement median filtering and apply on the image.
%  3. Change the window size and see its effect on filtering.
%  
% 

%%Reading the Image
img = imread('flower.png');
gray_img = im2double(rgb2gray(img));

isize = size(gray_img);

%%Adding Gaussian Noise to Image

gaussian_noise = randn(isize)*sqrt(0.01);

img_gaussian_noise = gray_img + gaussian_noise;

%%Adding Salt and pepper Noise to Image

img_salt_pepper_noise = gray_img;

noise = rand(isize);
img_salt_pepper_noise(noise < 0.05/2) = 0;
img_salt_pepper_noise(noise >= 0.05/2 & noise < 0.05) = 1;

%%Adding Random Noise to Image

random_noise = rand(isize)*sqrt(0.04);

img_random_noise = gray_img + random_noise;

%%Displaying the results
figure()
subplot(221)
imshow(gray_img)
title('Original Image')
subplot(222)
imshow(img_gaussian_noise)
title('Image with Gaussian Noise')
subplot(223)
imshow(img_salt_pepper_noise)
title('Image with Salt & Pepper Noise')
subplot(224)
imshow(img_random_noise)
title('Image with Random Noise')

%%Median Filtering
noise_images = cat(3,img_gaussian_noise,img_salt_pepper_noise,img_random_noise);
tic
winsize = [3,5,7];
for w = 1:3
    images = noise_images;
    wins = (winsize(w)-1)/2;
    for n = 1:3
        img_pad = padarray(images(:,:,n),[wins wins],'replicate','both');
        for i = wins+1:isize(1)+wins
            for j = wins+1:isize(2)+wins
                patch = img_pad(i-wins:i+wins,j-wins:j+wins);
                patch = patch(:);
                medpatch = median(patch);
                images(i-1,j-1,n) = medpatch;
            end
        end
    end
    
    %%Displaying the results
    figure(w+1)
    subplot(221)
    imshow(gray_img)
    title('Original Image')
    subplot(222)
    imshow(images(:,:,1))
    title('Image with Gaussian Noise')
    subplot(223)
    imshow(images(:,:,2))
    title('Image with Salt & Pepper Noise')
    subplot(224)
    imshow(images(:,:,3))
    title('Image with Random Noise')
    text(-180,-120,['Median Filtering with Window Size ',num2str(winsize(w))],'FontSize',15,'Color','r','HorizontalAlignment','center')  
end
toc
