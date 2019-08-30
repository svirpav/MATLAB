%% Clear The code
clear;
clc;

%% Import and cut image

img = imread('image_5.png');
imgCut = img(101:1948,101:1948);

count = 1;
step = 264;
a1 = 1;
a2 = 264;
b1 = 1;
b2 = 264;

%% Data processing

for i = 1 : 7
    for j = 1 : 7
        subname = strcat('A', num2str(count));
        subname2 = strcat('B', num2str(count));
        subname3 = strcat('C', num2str(count));
        subname4 = strcat('D', num2str(count));
        subname5 = strcat('E', num2str(count));
        imgCuts.(subname) = imgCut(b1:b2,a1:a2);
        imgCuts.(subname2) = [b1,b2;a1,a2];
        pixelVal = imgCuts.(subname)(:);
        imgCuts.(subname3) = mean(pixelVal);
        imgCuts.(subname4) = min(pixelVal);
        imgCuts.(subname5) = max(pixelVal);
        count = count + 1;
        a1 = a1 + step;
        a2 = a2 + step;
        
    end
    a1 = 1;
    a2 = 264;
    b1 = b1 + step;
    b2 = b2 + step;
end

count = 1;
for i = 1 : 7
    for j = 1 : 7
        subname3 = strcat('C', num2str(count));
        subname4 = strcat('D', num2str(count));
        subname5 = strcat('E', num2str(count));
        light(count, 1) = imgCuts.(subname3);
        light(count, 2) = imgCuts.(subname4);
        light(count, 3) = imgCuts.(subname5);
        lightAvg(count, 1) = imgCuts.(subname3);
        lightAvgGrid(i, j) = imgCuts.(subname3);
        count = count + 1;
    end
end



lightMax = max(lightAvg);

for i = 1 : 7
    for j = 1 : 7
       correction(i,j) = lightMax / lightAvgGrid(i,j);
    end
end

%correction_t = array2table(corection);
save('correction_t.mat', 'correction');
%% Plot processed data

imgSize = size(imgCuts.A49);
X = imgSize(1,1);
Y = imgSize(1,2);
xMax = X;
yMax = Y;
yMin = 1;
xMin = 1;
step = 1.0;
xPx = xMin:step:xMax;
yPx = yMin:step:xMax;
[xPx_2D, yPx_2D] = meshgrid(xPx, yPx);
ixPx_2D = fliplr(xPx_2D);
iyPx_2D = flipud(yPx_2D);

% Original Image

% Whole image view 0-255

%figure(1);
%contourf(LxPx_2D, LiyPx_2D, imgCut, 10);
%h = colorbar;
%hold on;

% Image cust grid 7x7

%figure(2);
%count = 1;

%for i = 1 : 7
%    for j = 1 : 7
%        subname = strcat('A', num2str(count));
%        subplot(7,7,count);
%        contourf(xPx_2D, iyPx_2D, imgCuts.(subname), 10);
%        count = count + 1;
%    end
%end
%hold on;

% 3D Average light mesh 7x7 cuts

ti = 1:1:7;
[XI, YI] = meshgrid(ti,ti);

figure(3);
mesh(XI, YI, lightAvgGrid);
hold on;

ti = 1:1:1848;
[XI, YI] = meshgrid(ti, ti);

figure(4);
mesh(XI,YI,imgCut);
hold on;