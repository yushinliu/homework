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
% compute optimal beta
lambda=0;
beta_1=eye(2,2);
beta_1=[zeros(2,1),beta_1];%insert colomn
beta_1=[zeros(1,3);beta_1];%insert row
beta = inv(X'*X-lambda*beta_1)*X'*Y; %inv: get inversed matrix  X':transposed matrix
% display the function
[a b] = meshgrid(-2:.1:2,-2:.1:2);%net matrix generated 
Xgrid = [ones(length(a(:)),1),a(:),b(:)];
Ygrid = Xgrid*beta;
Ygrid = reshape(Ygrid,size(a));%build a new matrix with same diminsion of a, put the Ygrid value in
h = surface(a,b,Ygrid);
view(3);%set 3d viewing angle
grid on;%open net grid