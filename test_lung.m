

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

 
 %%% segmentation
 [B, A] = imhist(initImage);
C=A.*B;
J=A.*A;
E=B.*J;
n=sum(B);
Average=sum(C)/sum(B);
var=sum(E)/sum(B)-Average*Average;
standDev= (var)^0.5;
thresholdValue = Average+0.5*standDev;
bwImage = initImage > thresholdValue;
figure

imshow(bwImage)
title('binary image');


bwImage=watershedtransf(bwImage);

labeledImage = bwlabel(bwImage, 8); 
RegionMeasurements = regionprops(labeledImage, initImage, 'all');
Ecc = [RegionMeasurements.Eccentricity];
RegionNo = size(RegionMeasurements, 1);
allowableEccIndexes =  (Ecc< 0.98);
keeperIndexes = find(allowableEccIndexes);
RegionImage = ismember(labeledImage, keeperIndexes);
bwImage=RegionImage;
figure
imshow(bwImage);
title('cancer spot', 'FontSize', FontSize);

peri=numel(bwperim(bwImage));
area=bwarea(bwImage)

%%%%% calculation of parameters

addpath('support');
  
fq2=[area peri];  %%% feature vectors

load SS

st{1}='CANCER';st{2}='NORMAL';
rst1=multisvmtest(fq2,4,SS)

msgbox(['Lung type is ', st{rst1}]);


%%% speech synthesis

NET.addAssembly('System.Speech');
speak = System.Speech.Synthesis.SpeechSynthesizer;
speak.Volume = 100;
speak.Speak(['Lung type is  ','   ', st{rst1}]);


if rst1==1  
    if area> 1000
        msgbox('Maliganant')
speak.Speak(['Cancer type is  ','   ','Malignant' ]);
    else 
        msgbox('Benign')  
speak.Speak(['Cancer type is  ','   ','Benign' ]);
    end   
end 


if rst1==1
%%% find manual image for selected image
cd manual
str=strcat(J1(1),'_mask.png')
K=imread(str);
cd ..

K=imresize(K,size(bwImage));
K=double(im2bw(K));
figure,imshow(K),title('Manual Image')
%%%%% finding parameters
%accuracy
%Sensitivity
%Specificivity
[AC,SE,SPE]=per_metric(bwImage,K)
end

%%% serial port
% http://www.mathworks.com/help/matlab/matlab_external/writing-and-reading-data.html
% s = serial('COM3');
% fopen(s)
% 
% fprintf(s,'MAL')
% % out = fscanf(s)
% fclose(s)
% delete(s)
% clear s



% %%%% display on IOT
% s = serial('COM3');
% set(s,'BaudRate',9600);
% fopen(s);
% RegionArea='MALIGNANT';
% pause(2)
% fprintf(s,'%s',RegionArea)
% 
% fclose(s)
%%% msg box display


