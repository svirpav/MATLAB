%% Clear + variable defention
clear;
clc;

title = 'Input';

% Enter X direction length
lenX = inputdlg('Eneter target x direction length', title);
lenX = cell2mat(lenX);
lenX = str2num(lenX);
%Enter Y direction length
lenY = inputdlg('Eneter target y direction length', title);
lenY = cell2mat(lenY);
lenY = str2num(lenY);
%Enter Square size
square = inputdlg('Enter quare size', title);
square = cell2mat(square);
square = str2num(square);

timesX = lenX / square - 1;
timesY = lenY / square - 1;


%% Load file
fid = fopen('4.TXT');
line = fgetl(fid); % skip the first line

iX = 1;
iY = 1;

for n = 1: (timesX * 3)
    line = fgetl(fid);
    tmp = sscanf(line, ['%c' '%f'], [1,2]);
    a = tmp(1,1);
    
    if a == 88
        b = tmp(1, 2);
        c(iX, 1) = b;
        iX = iX + 1;
    end
    
    if a == 89
        b = tmp(1, 2);
        c(iY, 2) = b;
        iY = iY + 1;
    end
    
    n = n + 1;
    
end

for n = 1: (timesX * 3)
    line = fgetl(fid);
    tmp = sscanf(line, ['%c' '%f'], [1,2]);
    a = tmp(1,1);
    
    if a == 88
        b = tmp(1, 2);
        c(iX, 1) = b;
        iX = iX + 1;
    end
    
    if a == 89
        b = tmp(1, 2);
        c(iY, 2) = b;
        iY = iY + 1;
    end
    
    n = n + 1;
    
end



%% Close file
fclose(fid);