clear;
% load the date
load('dataQuadReg2D_noisy.txt');
% plot it
figure(1);clf;hold on; %clf:clean the plot  hold on: keep the plot not change
plot3(dataQuadReg2D_noisy(:,1),dataQuadReg2D_noisy(:,2),dataQuadReg2D_noisy(:,3),'r.');%plot 3 clomns
% decompose in input X and output Y
n = size(dataQuadReg2D_noisy,1);
X = dataQuadReg2D_noisy(:,1:2);%X belongs to R2
Y = dataQuadReg2D_noisy(:,3);
% prepend 1s to inputs
X = [ones(n,1),X]; %ones(a,b)ROW=a CLOMN=b value=1
%Extend X to polynominals
X_squared = X.^2;
X_times=X(:,2).*X(:,3);
X=[X,X_squared(:,2:3),X_times];
% compute optimal beta
%lambda=100;
beta_1=eye(5,5);
beta_1=[zeros(5,1),beta_1];%insert colomn
beta_1=[zeros(1,6);beta_1];%insert row
%beta = inv(X'*X-lambda*beta_1)*X'*Y; %inv: get inversed matrix  X':transposed matrix

%compute training set and cross validation set
squared_error=0;
error_training=0;
lambda=0;
for j=1:10000
  lambda= lambda+0.1;
  lamb(:,j)=lambda;
   beta_training = inv(X'*X+lambda*beta_1)*X'*Y; %inv: get inversed matrix  X':transposed matrix
  cost_training=0.5*(X*beta_training-Y)'*(X*beta_training-Y)+0.5*lambda*beta_training'*beta_training;
  error_training=cost_training/sum(sum(abs(X)));
   S_training_error(:,j)=error_training;
for i=0:4
datasetX=X;
datasetY=Y;
datasetX(i*10+1:(i+1)*10,:)=[];
datasetY(i*10+1:(i+1)*10,:)=[];
datasetX_training=datasetX;
datasetX_testing=X(i*10+1:(i+1)*10,:);
datasetY_training=datasetY;
datasetY_testing=Y(i*10+1:(i+1)*10,:);
beta=inv(datasetX_training'*datasetX_training+lambda*beta_1)*(datasetX_training'*datasetY_training);
cost=0.5*(datasetX_testing*beta-datasetY_testing)'*(datasetX_testing*beta-datasetY_testing);%test without lambda
error=cost/sum(sum(abs(datasetX_testing)));
squared_error= squared_error + error;
end
S_error(:,j)=0.2*squared_error;
squared_error=0;
error_training=0;
end
% display the function
[a b] = meshgrid(-2:.1:2,-2:.1:2);%net matrix generated 
Xgrid = [ones(length(a(:)),1),a(:),b(:)];

%Extend Xgrid to polynominals
Xgrid_squared = Xgrid.^2;
Xgrid_times=Xgrid(:,2).*Xgrid(:,3);
Xgrid=[Xgrid,Xgrid_squared(:,2:3),Xgrid_times];
Ygrid = Xgrid*beta;
Ygrid = reshape(Ygrid,size(a));%build a new matrix with same diminsion of a, put the Ygrid value in
h = surface(a,b,Ygrid);
view(3);%set 3d viewing angle
grid on;%open net grid
%diplay the training set and cross validation set
figure(2);
plot(lamb,S_error,'g',lamb,S_training_error,'r');
set(gca,'XScale','log');
%set(gca,'YScale','log');