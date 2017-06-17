close all;  
clear all;  
  
%dimension is the pixels of image, n is training number
%read all traning images  
train_num = 135;  
  
trainpath = 'E:\FILES\learning\2nd_SEMESTER\ML\EXERCISE\ex6\yalefaces_cropBackground\';
file = 's*';%choosing the all pictures with intial s      
train_filenames = dir([trainpath file]);
%train_filenames = dir('.');    % return a structure with filenames        
  
  
I = [];  
for i = 1 : train_num  
    filename = [trainpath train_filenames(i).name];   % filename in the list  
    a = imread(filename);  
    vec = reshape(a,243*160,1); %reshape the matrix to the row of 243*320 and the column of 1
    I = [I vec];  
end  
I = double(I);  
%initial the center
init=[];
K = 4;
temp=[];
for j = 1 : K 
    init=[init 255*rand(243*160,1)];
end
%implement kmeans
centers=init;
new_centers=[];
dist=[];
for i = 1 : 10
    clusters=cell(1,4);
    for j = 1 : 135
        for p = 1 : K
        dist=[dist sum(abs(I(:,j)-centers(:,p)))];
        end
        [minr,index]=min(dist);
        clusters{index}=[clusters{index} I(:,j)];
        dist=[];
        index=0;
        minr=0;
    end
   for index = 1 : K
    temp=clusters{index};
    new_centers=[new_centers mean(temp')'];
   end
    centers=new_centers;
    new_centers=[];
end
        
    

