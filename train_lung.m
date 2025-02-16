clc;
clear all;
close all;
F=dir('TRAIN');
F=char(F.name);
sz=size(F,1)-2;
hh=waitbar(0,'Please wait system is training..');
for ii=1:sz
    st=F(ii+2,:);
    cd TRAIN
    I=imread(st);
    cd ..
    if size(I,3)>1
        I=im2bw(I);
    end

     area=bwarea(I);
     peri=numel(bwperim(I));
      
     fv2(ii,:)=[area peri]; 

     if strcmp(st(1:4),'MALI')==1
         grp(ii)=1;
     end
      if strcmp(st(1:4),'NORM')==1
         grp(ii)=2;
      end
    
     waitbar(ii/sz);
end
close(hh);
SS=multisvmtrain(fv2',grp);
save SS SS