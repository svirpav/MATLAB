%% Clear The code
clear;
clc;
%% Import and cut image

img = imread('img_8.png');
imgCut = img(101:1948,101:1948);

count = 1;
step = 264;
a1 = 1;
a2 = 264;
b1 = 1;
b2 = 264;

%% Cut Image

for i = 1 : 7
    for j = 1 : 7
        subname = strcat('A', num2str(count));
        subname2 = strcat('B', num2str(count));
        subname3 = strcat('C', num2str(count));
        subname4 = strcat('D', num2str(count));
        subname5 = strcat('E', num2str(count));
        imgCuts.(subname) = imgCut(b1:b2,a1:a2);
        imgCuts.(subname2) = [b1,b2;a1,a2];
        count = count + 1;
        a1 = a1 + step;
        a2 = a2 + step;
        
    end
    a1 = 1;
    a2 = 264;
    b1 = b1 + step;
    b2 = b2 + step;
end

load('correction_t.mat');

%% Process Image

count = 1;
step = 264;
a1 = 1;
a2 = 264;
b1 = 1;
b2 = 264;

for i = 1 : 7
    for j = 1 : 7
        subname = strcat('A', num2str(count));
        processedCut.(subname) = imgCuts.(subname) * correction(i,j);
        processedImage(b1:b2,a1:a2) = processedCut.(subname);
        a1 = a1 + step;
        a2 = a2 + step;
        count = count + 1;
    end
    a1 = 1;
    a2 = 264;
    b1 = b1 + step;
    b2 = b2 + step;
end
count = 1;
for i = 1 : 7
    for j = 1 : 7
        subname = strcat('A', num2str(count));
        pVal = processedCut.(subname)(:);
        pAvg(count,1) = mean(pVal);
        count = count + 1;
    end
end

pMin = min(pAvg);
pMax = max(pAvg);
pMean = mean(pAvg);

u = (1-(pMax - pMin)/pMean)*100;

%% 4 segment uniformity

count = 1;
step = 924;
a1 = 1;
a2 = 924;
b1 = 1;
b2 = 924;

for i = 1 : 2
    for j = 1 : 2
        subname = strcat('A', num2str(count));
        subname2 = strcat('B', num2str(count));
        subname3 = strcat('C', num2str(count));
        subname4 = strcat('D', num2str(count));
        subname5 = strcat('E', num2str(count));
        Seg.(subname) = processedImage(b1:b2,a1:a2);
        Seg.(subname2) = [b1,b2;a1,a2];
        count = count + 1;
        a1 = a1 + step;
        a2 = a2 + step;
    end
    a1 = 1;
    a2 = 924;
    b1 = b1 + step;
    b2 = b2 + step;
end

PVal_1 = Seg.A2(:);
PMax_1 = max(PVal_1);
PMax_1 = double(PMax_1);
PMin_1 = min(PVal_1);
PMin_1 = double(PMin_1);
PMean_1 = mean(PVal_1);

u_1 = (1 - (PMax_1 - PMin_1) ./ PMean_1) * 100;

%% Plot processed data

% Note processed light

imageSize = size(imgCut);
x = imageSize(1,1);
y = imageSize(1,2);

xy = 1:1:x;
[XI, YI] = meshgrid(xy, xy);

figure(1);
mesh(XI, YI, imgCut);

hold on;

figure(2);
mesh(XI, YI, processedImage);
hold on;

figure(4);
xy = 1:1:924;
[XI, YI] = meshgrid(xy, xy);
mesh(XI,YI, Seg.A2);
hold on;
