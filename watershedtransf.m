
function bwImage=watershedtransf(bwImage)
NewImage=bwImage;
J = -bwdist(NewImage);
% figure
% imshow(J,[])
Ld = watershed(J);
% figure
% 
% imshow(label2rgb(Ld))
% title('watershed image');

bw2 = NewImage;
bw2(Ld == 0) = 0;
% figure
% imshow(bw2)
mask = imextendedmin(J,1500);


D2 = imimposemin(J,mask);
Ld2 = watershed(D2);
bw3 = NewImage;
bw3(Ld2 == 0) = 0;

%%%%%%%%%%%%%%%%%%%%%%
bwImage=bw3;
bigMask = bwareaopen(bwImage, 2000);
finalImage = bwImage;
finalImage(bigMask) = false;


bwImage=bwareaopen(finalImage,70);
end