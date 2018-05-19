clear all;
close all;
clc;
X=[];
mapObj = containers.Map('KeyType','double','ValueType','double');
for i = 1:15
    [fname, path]=uigetfile('.jpg','Open a face as input for training');
    fname=strcat(path,fname);
    im=imread(fname);
    detector = vision.CascadeObjectDetector;
    bbox = step(detector, im);
    im = imcrop(im,bbox(1,:));
    im=rgb2gray(im);
    figure,imshow(im);
    im = imresize(im,[100 100]);
    [r, c] = size(im);
    temp = reshape(im',r*c,1);
    X=[X temp];
end
m = mean(X,2);
m1=reshape(m,100,100);
m1=m1';
figure,imshow(m1/255);
A = [];
for i=1 : 15
    temp = double(X(:,i)) - m;
    A = [A temp];
end
L= A' * A;
[V,D]=eig(L);
for i = 1 : size(V,2) 
    mapObj(D(i,i))=i;
end
L_eig_vec = [];
K=keys(mapObj);
le=length(K);
Aa=cell2mat(K);
v=sum(Aa);
csum=0;
i=le;
while i>=1
    csum=csum+Aa(i);
    tv=csum/v;
    st=mapObj(Aa(i));
    if tv<=1
        L_eig_vec=[L_eig_vec V(:,st)];
    else
        break;
    end
    i=i-1;
end
eigenfaces = [];
si=size(L_eig_vec,2);
for i=1:si
    temp=A*L_eig_vec(:,i);
    eigenfaces = [eigenfaces temp];
end
for i = 1:size(eigenfaces,2)
    m2=reshape(eigenfaces(:,i),100,100);
    m2=m2';
    figure,imshow(m2/255);
end
projectimg = [];
for i = 1 : 15
    W=[];
    U=double(X(:,i));
    for j = 1 : size(eigenfaces,2)
        temp=eigenfaces(:,j)' * (U-m);
        W=[W;temp];
    end;
    projectimg=[projectimg W];
end
save pp.mat projectimg
