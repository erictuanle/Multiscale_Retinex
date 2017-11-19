% This script aims at demonstrating the efficiency of the method
clc
clear
close all

% Parameters
path = 'Img/';
image = imread(strcat(path,'Diving.jpg'));
image = im2double(image);
figure
imshow(image)

% Running the MSRCR algorithm
sigmas = [15,80,250];
s1 = 2;
s2 = 2;
resulting_image = MSRCR(image,sigmas,s1,s2);
figure
imshow(uint8(resulting_image))
imwrite(uint8(resulting_image),strcat(path,'Diving_MSRCR.jpg'))

% Running the MSRCP algorithm
sigmas = [15,80,250];
s1 = 2;
s2 = 2;
resulting_image = MSRCP(image,sigmas,s1,s2);
figure
imshow(uint8(resulting_image),[])
imwrite(uint8(resulting_image),strcat(path,'Diving_MSRCP.jpg'))