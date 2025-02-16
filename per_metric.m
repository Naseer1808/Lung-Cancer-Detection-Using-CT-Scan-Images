function [AC,SE,SPE]=per_metric(img,M);
M=double(im2bw(M));
img=double(im2bw(img));
%figure,imshow(M);title('Manually segmented image');
%----------------------------------------------
id1=find(img==1);
id2=find(M==1);
sp=intersect(id1,id2);
tp=numel(sp);
fn=abs(numel(id2)-tp);
fp=abs(numel(id1)-tp);
id3=find(img==0);
id4=find(M==0);
sp2=intersect(id3,id4);
tn=numel(sp2);
%------------------------------------------------
%------------------------------------------------
 AC=(tp+tn)/(tp+tn+fp+fn);
 SE=tp/(tp+fn);
 SPE=tn/(tn+fp);
 

