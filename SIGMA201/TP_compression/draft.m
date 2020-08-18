close all
clear all
clc

root = 0;
x = -5:0.05:5;
y = -5:0.05:5;
z = -5:0.05:5;
[x,y,z] = meshgrid(x,y,z);
f = power((x.^2+2.25*y.^2+z.^2-1),3)-x.^2.*z.^3-0.1125*y.^2.*z.^3-root;
graph = patch(isosurface(x,y,z,f,0));
view(3)


