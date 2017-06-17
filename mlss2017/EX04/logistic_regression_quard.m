clear;
% load the date
load('data2Class.txt');
% decompose in input X and output Y
n = size(data2Class,1);
X = data2Class(:,1:2);%X belongs to R2
Y = data2Class(:,3);

% plot it
figure  
pos = find(Y == 1); neg = find(Y == 0);
plot(X(pos, 1), X(pos,2), 'g+')  
hold on  
plot(X(neg, 1), X(neg, 2), 'r+')  
hold on  
xlabel('axis X')  
ylabel('axis Y')
% initialize beta
beta_old = ones(6, 1); 
beta_new = zeros(6, 1); 
e = 0.0000000000001;
% define sigmoid function
g = inline('1.0 ./ (1.0 + exp(-z))'); %use inline to define function
% compute optimal beta using Newton methods
%lambda=100;
%for k =1:n
    %if data2Class(k,3)
        %X(k,3:4)=data2Class(k,1:2)
        %X(k,1:2)=0
    %else   
        %X(k,1:2)=data2Class(k,1:2)
    %end
    
%end
% prepend 1s to inputs
X = [ones(n,1),X]; %ones(a,b)ROW=a CLOMN=b value=1
%Extend X to polynominals
X_squared = X.^2;
X_times=X(:,2).*X(:,3);
X=[X,X_squared(:,2:3),X_times];

while ((beta_new - beta_old)*(beta_new - beta_old)' > e) 
%compute loss function
%%error=0;
%lambda=0;
%for j=1:10000
  %lambda= lambda+0.001;
  %lamb(:,j)=lambda;
  beta_old = beta_new;
  z= X*beta_new; %in normal equation not beta'*X
  hypothsis=g(z);
  % Calculate gradient and hessian
  grad=X'*(hypothsis-Y)
  hessian=X'*diag(hypothsis)*diag(1-hypothsis)*X;
  beta_new =beta_new - hessian\grad; %use \ to hessian^-1*grad  
  
  %error=cost/sum(sum(abs(X)));
%S_error(:,j)=error;
%error=0;
end

% display the function
%plot_X = [X(:,2)]; 
%plot_Y = [X(:,3)];
f=@(x, y)beta_new(1)+beta_new(2).*x+beta_new(3).*y+beta_new(4).*x.^2+beta_new(5).*y.^2+beta_new(6).*x.*y;
ezplot(f,[-3,3]);
%plot_Y = (-1./beta_new(3)).*(beta_new(5).*plot_Y.^2+beta_new(6).*plot_X.*plot_Y+beta_new(4).*plot_X.^2+beta_new(2).*plot_X +beta_new(1)); %X2=-(beta1*X1+beta0)/beta2  
legend('Label 1', 'Label 2', 'Decision Boundary')  
hold off 
figure(2);
plot3(data2Class(:,1),data2Class(:,2),data2Class(:,3),'r.');%plot 3 clomns
[a b] = meshgrid(-2:.1:2,-2:.1:2);%net matrix generated 
Xgrid = [ones(length(a(:)),1),a(:),b(:)];
%Extend Xgrid to polynominals
Xgrid_squared = Xgrid.^2;
Xgrid_times=Xgrid(:,2).*Xgrid(:,3);
Xgrid=[Xgrid,Xgrid_squared(:,2:3),Xgrid_times];
Ygrid = 1./(exp(-Xgrid*beta_new)+1);
Ygrid = reshape(Ygrid,size(a));%build a new matrix with same diminsion of a, put the Ygrid value in
h = surface(a,b,Ygrid);
view(3);%set 3d viewing angle
grid on;%open net grid