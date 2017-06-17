close all;  
clear all;  
  
%read all traning images  
train_num = 166;  
test_num = 10;  
img_dims = [243 320];  
  
trainpath = 'E:\FILES\learning\2nd_SEMESTER\ML\EXERCISE\ex05\yalefaces\trainingset\';  
testpath = 'E:\FILES\learning\2nd_SEMESTER\ML\EXERCISE\ex05\yalefaces\trainingset\subject01.happy';  
file = 's*';      
train_filenames = dir([trainpath file]);    % return a structure with filenames  
test_filenames = dir([testpath file]);        
  
  
A = [];  
for i = 1 : train_num  
    filename = [trainpath train_filenames(i).name];   % filename in the list  
    a = imread(filename);  
    vec = reshape(a,243*320,1);  
    A = [A vec];  
end  
A = double(A);  
  
%find the mean face and substract it from origin face  
mean_face = mean(A,2);  
  
A1 = A;  
for i = 1 : train_num  
    A1(:,i) = A(:,i) - mean_face;  
end  
  
A1 = double(A1);  
[ah,aw] = size(A1);  
  
%Peform PCA on the data matrix  
C = (1/train_num) * A1' * A1;  
[ch,cw] = size(C);  
  
%calculate the top 15 eigenvectors and eigenvalues  
[V,D] = eigs(C,15);  
  
%Compute the eigenfaces  
eigenface = [];  
for i = 1 : 15  
    mv = A1 * V(:,i);  
    mv = mv/norm(mv);  
    eigenface = [eigenface mv];  
    [eh,ew] = size(eigenface);  
end  
  
%Display the 15 eigenfaces  
figure;  
for i = 1:15  
    im = eigenface(:,i);  
    im = reshape(im,243,320);  
    subplot(3,5,i);  
    im = imagesc(im);colormap('gray');  
end  
  
%Project each training image onto the new space  
img_project = [];  
for i = 1:train_num  
    temp = double(A1(:,i)') * eigenface ;  
    img_project = [img_project temp'];  
end  
  
  
%read the test image  
input_img = imread(testpath);  
input_img = imresize(input_img,img_dims);  
[p,q] = size(input_img);  
temp = reshape(input_img,p*q,1);  
temp = double(temp) - mean_face;  
%calculate the similarity of the input to each training image  
feature_vec = temp' * eigenface ;  
  
dist = [];  
for i = 1 : train_num  
    distance = norm(feature_vec' - img_project(:,i))^2;  
    dist = [dist distance];  
end  
  
[dist_min index] = sort(dist);  
num1 = index(1);  
num2 = index(2);  
num3 = index(3);  
  
img1 = A(:,num1);  
img1 = reshape(uint8(img1),243,320);  
img2 = A(:,num2);  
img2 = reshape(uint8(img2),243,320);  
img3 = A(:,num3);  
img3 = reshape(uint8(img3),243,320);  
  
figure;  
subplot(1,4,1);  
imshow(input_img);  
title('Test image');  
  
subplot(1,4,2);  
imshow(img1);  
title('Recognition image1');  
  
subplot(1,4,3);  
imshow(img2);  
title('Recognition image2')  
  
subplot(1,4,4);  
imshow(img3);  
title('Recognition image3') 