%% Clear The code
clear;
clc;
%% Import crop and apply camera correct factor;

imgRaw  = imread('img_24.png');
imgCrop = imgRaw(101:1948,101:1948);

sizeImg_1 = size(imgCrop);
sizeImg_1 = sizeImg_1(1,1);

iAreOfInterest  = 1036;
sizeCrop        = (sizeImg_1 - iAreOfInterest)/2;
offset_1        = -180;
offset_2        = 5;

x_1 = 1 + sizeCrop + offset_1;
x_2 = iAreOfInterest + sizeCrop + offset_1;
y_1 = 1 + sizeCrop + offset_2;
y_2 = iAreOfInterest + sizeCrop + offset_2;


imgCropOrig = imgCrop(x_1:x_2, y_1:y_2);

figure(1);
imshow(imgCropOrig);