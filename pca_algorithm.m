%load pp.mat
%x4=videoinput('winvideo',1);
%preview(x4);
%set(x4,'ReturnedColorSpace','rgb');
%pause(10);
%a=getsnapshot(x4);
close all;
B3={'Agnika','Agnika','Agnika','Agnika','Agnika','Madhavi','Madhavi','Madhavi','Madhavi','Madhavi','Tarani','Tarani','Tarani','Tarani','Tarani'};
[fname, path]=uigetfile('.jpg','Open a face as input for training');
 fname=strcat(path,fname);
 a=imread(fname);
fdetector = vision.CascadeObjectDetector;
BBox = step(fdetector, a);
figure;
imshow(a); hold on
for i = 1:size(BBox,1)
    rectangle('Position',BBox(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off
[M3,N3] = size(BBox);
for j=1:M3
I2 = imcrop(a,BBox(j,:));
I2=rgb2gray(I2);
I2 = imresize(I2,[100 100]);
figure,imshow(I2);
[r1, c1] = size(I2);
temp1 = reshape(I2',r1*c1,1);
temp1 = double(temp1)-m;
projtestimg = eigenfaces' * temp1;
euclide_dist = [];
for i=1 : size(projectimg,2)
    temp1 = (norm(projtestimg-projectimg(:,i)))^2;
    euclide_dist = [euclide_dist temp1];
end
[euclide_dist_min recognized_index] = min(euclide_dist);
h=msgbox(B3(recognized_index) , 'Detected Class' , 'help');
end


        



    
    