%%
% _Assignment 3_
%
% *Question 1*
% 
% Point Detection
% 
% 1. Read an image. (You can take the image ‘various.jpg’)
% 
% 2. Apply the Laplacian mask W to it.
% 
% 3. Choose the threshold point to be maximum magnitude of the image obtained from the previous step.
% 
% 4. Detect it and display the image.
%        W = [ 	-1 -1 -1
%
%           	-1  8 -1
%
%               -1 -1 -1 ]

img = imread('building.jpg');
gimg = im2double(rgb2gray(img));
[nrow,ncol] = size(gimg);
W = [-1,-1,-1;-1,8,-1;-1,-1,-1];
imglap = conv2(gimg,W,'same');
threshold = max(max(gimg));
[rowpt,colpt] = find(imglap>=threshold & imglap<=1.2*threshold);
imshow(gimg)
hold on
plot(colpt,rowpt,'gs')