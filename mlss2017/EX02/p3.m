clear;
% load the date
load('dataQuadReg2D_noisy.txt');
% decompose in input X and output Y
n = size(dataQuadReg2D_noisy,1);
X = dataQuadReg2D_noisy(:,1:2);
Y = dataQuadReg2D_noisy(:,3);

%Quadratic feature
X = [ones(n,1),X];
%compute x1*x1
for k = 1:50
    Z(k,1) = X(k,2)*X(k,2);
end   
X = [X,Z];
%compute x1*x2
for k = 1:50
    Z(k,1)=X(k,2)*X(k,3);
end   
X = [X,Z];
%compute x2*x2
for k = 1:50
    Z(k,1)=X(k,3)*X(k,3);
end
X = [X,Z];

loss = zeros(5,1);

for m =1:1000
    lambda(:,m) = 0 + m*1;
%cross validation    
  for k =0:4
  X_traing = X (1:k*10,:);
  X_traing = [X_traing;X((k+1)*10+1:50,:)]
  X_test = X((10*k+1):(10*k+10),:);
  Y_traing = Y (1:k*10,:);
  Y_traing = [Y_traing;Y((k+1)*10+1:50,:)]
  Y_test = Y((10*k+1):(10*k+10),:);
  lembda_I =  lambda(:,m)*eye(6);
  lembda_I(1,1) = 0 ;
  beta = inv((X_traing)'*X_traing+lembda_I)*(X_traing)'*Y_traing;
  
  sum = 0;
  Difference = Y_test - X_test * beta;
     for i = 1:10
      sum = sum + Difference(i)*Difference(i);
     end    
  loss((k+1),1) = sum ;
  end
lose_average(:,m) = mean (loss);

%traing all date to get the squared error
squared_error(:,m) = 0;
sum_2 = 0;
lembda_I = lambda(:,m)*eye(6);
lembda_I(1,1) = 0 ;
beta = inv(X'*X+lembda_I)*X'*Y;
Difference = Y - X * beta;


    for i = 1:50
     squared_error(:,m) = squared_error(:,m)+ Difference(i)*Difference(i);
    end
    for j = 2:6
       sum_2 = sum_2 + beta(j)*beta(j);
    end
    squared_error(:,m) = squared_error(:,m) +  lambda(:,m) *sum_2;
end
figure(2);
plot(lambda , lose_average );
