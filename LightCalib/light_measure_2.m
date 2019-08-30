%% Clear The code
clear;
clc;
%% Import crop and apply camera correct factor;

imgRaw  = imread('img_39.png');
imgCrop = imgRaw(101:1948,101:1948);

imgOrig = imgCrop;

% Load correction table
load('correction_t.mat');

% Cut image 7 x 7;

zone_1      = 7;
sizeImg_1   = size(imgCrop);
sizeImg_1   = sizeImg_1(1,1);
step_1      = sizeImg_1 / 7;

a1 = 1;
a2 = step_1;
b1 = 1;
b2 = step_1;

count = 1;
for i = 1 : zone_1
    for j = 1 : zone_1
        subname                 = strcat('A', num2str(count));
        subname2                = strcat('B', num2str(count));
        subname3                = strcat('C', num2str(count));
        sample_Init.(subname)   = imgCrop(b1:b2, a1:a2);
        sample_Init.(subname2)  = [b1,b2;a1,a2];
        sample_Init.(subname3)  = sample_Init.(subname) * correction(i,j);
        imgCorr(b1:b2, a1:a2)   = sample_Init.(subname3);
        a1                      = a1 + step_1;
        a2                      = a2 + step_1;
        count                   = count + 1;
    end
    a1  = 1;
    a2  = step_1;
    b1  = b1 + step_1;
    b2  = b2 + step_1;
end

%% Full Image processing/measurment

% Crop and align image;

iAreOfInterest  = 1036;
sizeCrop        = (sizeImg_1 - iAreOfInterest)/2;
offset_1        = -180;
offset_2        = 5;

x_1 = 1 + sizeCrop + offset_1;
x_2 = iAreOfInterest + sizeCrop + offset_1;
y_1 = 1 + sizeCrop + offset_2;
y_2 = iAreOfInterest + sizeCrop + offset_2;


imgCropOrig = imgOrig(x_1:x_2, y_1:y_2);
imgCropCorr = imgCorr(x_1:x_2, y_1:y_2);

pxMin = min(imgCropOrig(:));
pxMax = max(imgCropOrig(:));

% Create image samples

step_2  = iAreOfInterest / zone_1;
a1      = 1;
a2      = step_2;
b1      = 1;
b2      = step_2;

count = 1;
for i = 1 : zone_1
    for j = 1 : zone_1
        subname                 = strcat('A', num2str(count));
        subname2                = strcat('B', num2str(count));
        sample_Orig.(subname)   = imgCropOrig(b1:b2, a1:a2);
        sample_Corr.(subname)   = imgCropCorr(b1:b2, a1:a2);
        sample_Orig.(subname2)  = [b1, b2; a1, a2];
        sample_Corr.(subname2)  = [b1, b2; a1, a2];
        origPx                  = sample_Orig.(subname)(:);
        corrPx                  = sample_Corr.(subname)(:);
        tablePxOrig(count, 1)   = mean(origPx);
        tablePxCorr(count, 1)   = mean(corrPx);
        mapPxOrig(i, j)         = mean(origPx);
        mapPxCorr(i, j)         = mean(corrPx);
        a1                      = a1 + step_2;
        a2                      = a2 + step_2;
        count                   = count + 1;
    end
    a1 = 1;
    a2 = step_2;
    b1 = b1 + step_2;
    b2 = b2 + step_2;
end

% Uniformiti calculation 

fullPxOrigMin   = min(tablePxOrig);
fullPxOrigMax   = max(tablePxOrig);
fullPxOrigMean  = mean(tablePxOrig);

fullPxCorrMin   = min(tablePxCorr);
fullPxCorrMax   = max(tablePxCorr);
fullPxCorrMean  = mean(tablePxCorr);

uFullOrig = (1-(fullPxOrigMax - fullPxOrigMin) / fullPxOrigMean) * 100;
uFullCorr = (1-(fullPxCorrMax - fullPxCorrMin) / fullPxCorrMean) * 100;

%% 4 segment Image processing/measurment

% Create 2x2 samples

zone_2 = 2;
step_3 = iAreOfInterest / zone_2;

a1 = 1;
a2 = step_3;
b1 = 1;
b2 = step_3;

count = 1;
for i = 1 : zone_2
    for j = 1 : zone_2
        subname                 = strcat('A', num2str(count));
        subname2                = strcat('B', num2str(count));
        sample_SegOrig.(subname)  = imgCropOrig(b1:b2, a1:a2);
        sample_SegOrig.(subname2) = [b1, b2; a1, a2];
        sample_SegCorr.(subname)  = imgCropCorr(b1:b2, a1:a2);
        sample_SegCorr.(subname2) = [b1, b2; a1, a2];
        a1 = a1 + step_3;
        a2 = a2 + step_3;
        count = count + 1;
    end
    a1 = 1;
    a2 = step_3;
    b1 = b1 + step_3;
    b2 = b2 + step_3;
end

% Uniformity for 2x2 samples 


step_4 = 172;
a1 = 1;
a2 = step_4;
b1 = 1;
b2 = step_4;

count = 1;
for i = 1 : 3
    for j = 1 : 3
        subname = strcat('A', num2str(count));
        subname2 = strcat('B', num2str(count));
        sample_SegOrigA1.(subname) = sample_SegOrig.A1(b1:b2,a1:a2);
        sample_SegOrigA1.(subname2) = [b1,b2;a1,a2];
        segPxA1 = sample_SegOrigA1.(subname)(:);
        tableSegPxA1(count, 1) = mean(segPxA1);
        mapSegPxA1(i, j) = mean(segPxA1);
        sample_SegOrigA2.(subname) = sample_SegOrig.A2(b1:b2,a1:a2);
        sample_SegOrigA2.(subname2) = [b1,b2;a1,a2];
        segPxA2 = sample_SegOrigA2.(subname)(:);
        tableSegPxA2(count, 1) = mean(segPxA2);
        mapSegPxA2(i, j) = mean(segPxA2);
        sample_SegOrigA3.(subname) = sample_SegOrig.A3(b1:b2,a1:a2);
        sample_SegOrigA3.(subname2) = [b1,b2;a1,a2];
        segPxA3 = sample_SegOrigA3.(subname)(:);
        tableSegPxA3(count, 1) = mean(segPxA3);
        mapSegPxA3(i, j) = mean(segPxA3);
        sample_SegOrigA4.(subname) = sample_SegOrig.A4(b1:b2,a1:a2);
        sample_SegOrigA4.(subname2) = [b1,b2;a1,a2];
        segPxA4 = sample_SegOrigA4.(subname)(:);
        tableSegPxA4(count, 1) = mean(segPxA4);
        mapSegPxA4(i, j) = mean(segPxA4);
        count = count + 1;
        a1 = a1 + step_4;
        a2 = a2 + step_4;
    end
    a1 = 1;
    a2 = step_4;
    b1 = b1 + step_4;
    b2 = b2 + step_4;
end

segA1min = min(tableSegPxA1);
segA1max = max(tableSegPxA1);
segA1mean = mean(tableSegPxA1);

segA2min = min(tableSegPxA2);
segA2max = max(tableSegPxA2);
segA2mean = mean(tableSegPxA2);

segA3min = min(tableSegPxA1);
segA3max = max(tableSegPxA1);
segA3mean = mean(tableSegPxA1);

segA4min = min(tableSegPxA4);
segA4max = max(tableSegPxA4);
segA4mean = mean(tableSegPxA4);

uSegA1 = (1-(segA1max - segA1min)/segA1mean) * 100;
uSegA2 = (1-(segA2max - segA2min)/segA2mean) * 100;
uSegA3 = (1-(segA3max - segA3min)/segA3mean) * 100;
uSegA4 = (1-(segA4max - segA4min)/segA4mean) * 100;

%% Second correection

secondCorrectionMax = max(tablePxOrig);
count = 1;
for i = 1 : zone_1
    for j = 1 : zone_1
        secontCorrectionT(count, 1) = secondCorrectionMax / tablePxOrig(count, 1);
        count = count + 1;
    end
end

a1 = 1;
a2 = step_2;
b1 = 1;
b2 = step_2;

count = 1;
for i = 1 : zone_1
    for j = 1 : zone_1
        subname = strcat('A', num2str(count));
        sampleSecondCorr.(subname) = sample_Orig.(subname) * secontCorrectionT(count, 1);
        secondPx = sampleSecondCorr.(subname)(:);
        secondPxMeanT(count, 1) = mean(secondPx);
        imgSeconCorr(b1:b2, a1:a2) = sampleSecondCorr.(subname);
        count = count + 1;
        a1 = a1 + step_2;
        a2 = a2 + step_2;
    end
    a1 = 1;
    a2 = step_2;
    b1 = b1 + step_2;
    b2 = b2 + step_2;
end

secondPxMin = min(secondPxMeanT);
secondPxMax = max(secondPxMeanT);
secondPxMean = mean(secondPxMeanT);

uSecondPx = (1-(secondPxMax - secondPxMin) / secondPxMean) * 100;
uSecondPx = uSecondPx - (uSecondPx * 0.107);
uError = 89.3 - uSecondPx;



%% Plot processed data

% Note processed light

imageSize = size(imgCropOrig);
x = imageSize(1,1);
y = imageSize(1,2);

xy = 1:1:x;
[XI, YI] = meshgrid(xy, xy);
YI = flipud(YI);
%figure(1);
%mesh(XI, YI, imgCut);

%figure(2);
%mesh(XI, YI, processedImage);

figure(1);
clims = [pxMin pxMax];
imagesc(imgCropOrig, clims);
colormap('hot');
h = colorbar;
hold on;

figure(2);
imagesc(imgCropCorr);
colormap('hot');
h = colorbar;
hold on;

figure(3);
imagesc(imgSeconCorr);
colormap('hot');
h = colorbar;
hold on;

