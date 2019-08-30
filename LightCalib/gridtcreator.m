clear;
clc;

ti = 1:1:7;
[XI, YI] = meshgrid(ti,ti);

count = 1;


for i = 1 : 7
    for j = 1 : 7
        x (count, 1) = j;
        y (count, 1) = i;
        v (count, 1) = count * 10;
        count = count + 1;
    end
end

GD = griddata(x,y,v,XI,YI);
GD_3D = mesh(XI,YI,GD);
