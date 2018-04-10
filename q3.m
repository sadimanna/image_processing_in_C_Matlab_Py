%%
% 
%  Edge Detection
%1. Read an image.
%2. Apply Sobel edge detection to it with the parameters ‘vertical’, ‘horizontal’ and ‘both’ and display the images in each case.
%3. Check the result by applying other edge detection techniques

img = imread('building.jpg');
gimg = im2double(rgb2gray(img));
imgsize = size(gimg);

sobelh = edge(gimg,'sobel','horizontal');
sobelv = edge(gimg,'sobel','vertical');
sobelb = edge(gimg,'sobel','both');

%figure(1)
%imshow(gimg)
%title('Original Image')
%figure(2)
%imshow(sobelh)
%title('Sobel Horizontal')
%figure(3)
%imshow(sobelv)
%title('Sobel Vertical')
%figure(4)
%imshow(sobelb)
%title('Sobel Both')

prewitt = edge(gimg,'prewitt');
roberts = edge(gimg,'roberts');
canny = edge(gimg,'canny');
log = edge(gimg,'log');

figure(5)
imshow(prewitt)
title('Prewitt')
figure(6)
imshow(roberts)
title('Roberts')
figure(7)
imshow(canny)
title('Canny')
figure(8)
imshow(log)
title('LoG')