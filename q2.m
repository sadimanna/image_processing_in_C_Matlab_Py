%%
% 
%  Line Detection
% 
% 1. Read an image.
%
% 2. Apply the horizontal (Wh), vertical, plus 45 degree, minus 45 degree masks 
% and display the images in each case
%
% Wh = [ -1 -1 -1;  Wv = [-1  2 -1;  Wp45 = [2  -1 -1;    Wm45 = [-1 -1  2;
%
%         2  2  2;        -1  2 -1;          -1  2 -1;            -1  2 -1;
%          
%        -1 -1 -1]        -1  2 -1]          -1 -1  2]             2 -1 -1]
%
%

img = imread('building.jpg');
gimg = im2double(rgb2gray(img));
imgsize = size(gimg);

Wh = [-1,-1,-1;2,2,2;-1,-1,-1];
Wv = [-1,2,-1;-1,2,-1;-1,2,-1];
Wp45 = [2,-1,-1;-1,2,-1;-1,-1,2];
Wm45 = [-1,-1,2;-1,2,-1;2,-1,-1];
 
gimgh = conv2(gimg,Wh,'same');
gimgw = conv2(gimg,Wv,'same');
gimgp45 = conv2(gimg,Wp45,'same');
gimgm45 = conv2(gimg,Wm45,'same');

figure(1)
imshow(gimgh)
title('Horizontal edges')
figure(2)
imshow(gimgw)
title('Vertical edges')
figure(3)
imshow(gimgp45)
title('+45 degrees edges')
figure(4)
imshow(gimgm45)
title('-45 degrees edges')