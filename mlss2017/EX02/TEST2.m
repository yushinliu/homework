clear;
% load the date
load('dataQuadReg2D.txt');
% plot it
figure(1);clf;hold on; %clf:clean the plot  hold on: keep the plot not change
%plot3(dataLinReg2D(:,1),dataLinReg2D(:,2),dataLinReg2D(:,3),'r.');%plot 3 clomns
% decompose in input X and output Y
n = size(dataQuadReg2D,1);
X = dataQuadReg2D(:,1:2);%X belongs to R2
Y = dataQuadReg2D(:,3);
% prepend 1s to inputs
X = [ones(n,1),X]; %ones(a,b)ROW=a CLOMN=b value=1
%Extend X to polynominals
X_squared = X.^2;
X_times=X(:,2).*X(:,3);
X=[X,X_squared(:,2:3),X_times];
% compute optimal beta
lambda=100;
beta_1=eye(5,5);
beta_1=[zeros(5,1),beta_1];%insert colomn
beta_1=[zeros(1,6);beta_1];%insert row
beta = inv(X'*X-lambda*beta_1)*X'*Y; %inv: get inversed matrix  X':transposed matrix
% display the function
[a b] = meshgrid(-2:.1:2,-2:.1:2);%net matrix generated 
Xgrid = [ones(length(a(:)),1),a(:),b(:)];
Ygrid = Xgrid*beta;
Ygrid = reshape(Ygrid,size(a));%build a new matrix with same diminsion of a, put the Ygrid value in
h = surface(a,b,Ygrid);
view(3);%set 3d viewing angle
grid on;%open net grid