%%% reseting commands 
clc;
clear all;
close all;

%%% select input image
cd TEST_IMAGES
FontSize = 12;
[J1 P]=uigetfile('*.*','select an image for lung cancer detection');

initImage =(imread(strcat(P,J1)));
imshow(initImage),title('Input Image')
cd ..

%%% gray conversion
[rows, columns] = size(initImage);
initImage = rgb2gray(initImage);


figure,imshow(initImage),title('Input gray Image')
 
%%% median filter

initImage = medfilt2(initImage,[9 12]);

 figure,imshow(initImage),title('Filtered Image')