close all;  
clear all;  
  
%dimension is the pixels of image, n is training number
%read all traning images  
train_num = 165;  
  
trainpath = 'E:\FILES\learning\2nd_SEMESTER\ML\EXERCISE\ex05\yalefaces\trainingset\';
file = 's*';%choosing the all pictures with intial s      
train_filenames = dir([trainpath file]);
%train_filenames = dir('.');    % return a structure with filenames        
  
  
I = [];  
for i = 1 : train_num  
    filename = [trainpath train_filenames(i).name];   % filename in the list  
    a = imread(filename);  
    vec = reshape(a,243*320,1); %reshape the matrix to the row of 243*320 and the column of 1
    I = [I vec];  
end  
I = double(I);  
I_1=I;
%the average mean face
mean_face = mean(I,2); 
for i = 1 : train_num  
    I_1(:,i) = I_1(:,i) - mean_face;  
end 
I_1 = double(I_1);
%caculate the covariance
%C = (1/train_num) * I_1' * I_1;    
%caculate the SVD
[U, S, V]= svd(I_1,'econ') %using the covariance or X is the same 
%p-dimensional representation
Vreduce=V(:,1:15)
Z=I_1*Vreduce

%Reconstruct the faces
I_re=Z*Vreduce'
for i = 1 : train_num  
    I_re(:,i) = I_re(:,i) + mean_face;  
   
end 
I_re=double(I_re);
%plot
for i = 1 : train_num  
    pic = reshape(uint8(I_re(:,i)),243,320); 
    subplot(15,11,i)%to divided into small plot
    imshow(pic);
end 
%report error
mean_error=0;
for i = 1 : train_num  
   error = (I_re(:,i) - I(:,i)).^2;  
   mean_error=mean_error+error;
end 
mean_error=(1/train_num).*mean_error;%sum(x) for column
