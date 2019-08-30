clear;
clc;

%% Create matrix

len = 172.5;
square = 2.5;
times = len / square;


locY = 0;

row = 2;

for iY = 1 : times + 1
    locX = 0;
    for iX = 1 : times + 1
        tableX(iY, iX) = locX;
        tableY(iY, iX) = locY;
        locX = locX + square;
        iX = iX + 1;
    end
    
    locY = locY + square;
    iY = iY + 1;
end




   
