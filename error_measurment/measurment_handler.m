clear;
clc;

%% Open File and get file lenght

% Create file descriptor

fid = fopen('1.TXT');
file = textscan(fid, '%s', 'Delimiter', '\n');

i = 1;

while lines <= 1 
    tmp = size(file{1,1});
    lines = tmp(1,i);
    i = i + 1;
end
  
fclose(fid); 
    
%% Calculate target X direction error

fid = fopen('1.TXT');

i = 1;
x = 1;

while i  < 72 + 1
    line = fgetl(fid);
    tmp = sscanf(line, ['%c %f'], [1 2]);
    
    if tmp(1, 1) == 88
        table (x,1) = tmp(1, 2);
        x = x + 1;
    end
    i = i + 1;
end

x_direction = table(2,1) - table(1,1);
x_error = 172.5 - x_direction;
x_error = (x_error / 172.5) * 100;

square = 2.5;
length = 172.5;

count = length / square;
i = 1;
value = 0;
while i < count + 1
    value = value + square;
    tabel_1(i, 1) = value;
    i = i + 1;
end

i = 1;
value = 0;

while i < count + 1
    value = tabel_1(i,1) - tabel_1(i,1)*x_error / 100;
    tabel_1(i, 2) = value;
    i = i + 1;
end


%% Close file

fclose(fid);