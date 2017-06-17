clear;
% load the date
load('dataLinReg2D.txt');
% plot it
figure(1);clf;hold on; %clf:clean the plot  hold on: keep the plot not change
%plot3(dataLinReg2D(:,1),dataLinReg2D(:,2),dataLinReg2D(:,3),'r.');%plot 3 clomns
% decompose in input X and output Y
n = size(dataLinReg2D,1);
X = dataLinReg2D(:,1:2);%X belongs to R2
Y = dataLinReg2D(:,3);
% prepend 1s to inputs
X = [ones(n,1),X]; %ones(a,b)ROW=a CLOMN=b value=1
% compute optimal beta
%lambda=100;
beta_1=eye(2,2);
beta_1=[zeros(2,1),beta_1];%insert colomn
beta_1=[zeros(1,3);beta_1];%insert row
%beta = inv(X'*X-lambda*beta_1)*X'*Y; %inv: get inversed matrix  X':transposed matrix

%compute loss function
squared_error=0;
lambda=0;
for j=1:10000
  lambda= lambda+0.0001;
  lamb(:,j)=lambda;
for i=1:9
datasetX=X;
datasetY=Y;
datasetX(i*10:i*10+9,:)=[];
datasetY(i*10:i*10+9,:)=[];
datasetX_training=datasetX;
datasetX_testing=X(i*10:i*10+9,:);
datasetY_training=datasetY;
datasetY_testing=Y(i*10:i*10+9,:);
beta=inv(datasetX_training'*datasetX_training-lambda*beta_1)*(datasetX_training'*datasetY_training);
loss=0.5*(datasetX_testing*beta-datasetY_testing)'*(datasetX_testing*beta-datasetY_testing)+0.5*lambda*beta'*beta;
error=loss/sum(sum(abs(datasetX_testing)));
squared_error= squared_error + error;
end
S_error(:,j)=squared_error;
squared_error=0;
end
%diplay the plot between lambda and mean squared error
plot(lamb,S_error);
set(gca,'XScale','log');
% display the function
%[a b] = meshgrid(-2:.1:2,-2:.1:2);%net matrix generated 
%Xgrid = [ones(length(a(:)),1),a(:),b(:)];
%Ygrid = Xgrid*beta;
%Ygrid = reshape(Ygrid,size(a));%build a new matrix with same diminsion of a, put the Ygrid value in
%h = surface(a,b,Ygrid);
%view(3);%set 3d viewing angle
%grid on;%open net grid