% Logstic Regress with Newton's Method  
  
clear all; close all; clc  
  
% load the date
load('data2Class.txt');
% plot it
figure(1);clf;hold on; %clf:clean the plot  hold on: keep the plot not change
plot3(data2Class(:,1),data2Class(:,2),data2Class(:,3),'r.');%plot 3 clomns
% decompose in input X and output Y
n = size(data2Class,1);
X = data2Class(:,1:2);%X belongs to R2
Y = data2Class(:,3);
[m, n] = size(X);  
  
% x0 = 1  
X = [ones(m, 1), X];   
  
% plot the datas  
figure  
pos = find(Y); neg = find(Y == 0);%find是找到的一个向量，其结果是find函数括号值为真时的值的编号  
plot(X(pos, 2), X(pos,3), '+')  
hold on  
plot(X(neg, 2), X(neg, 3), 'o')  
hold on  
xlabel('axis X')  
ylabel('axis Y')  
  
% Initialize fitting parameters  
theta_new = zeros(n+1, 1);  
theta_old = ones(n+1, 1);  
e = 0.00000000001;  
  
% Define the sigmoid function  
g = inline('1.0 ./ (1.0 + exp(-z))');   
  
% Newton's method  
while ((theta_new - theta_old)*(theta_new - theta_old)' > e)  
    theta_old = theta_new;  
    % Calculate the hypothesis function  
    z = X * theta_new;  
    h = g(z);  
       
    % Calculate gradient and hessian.  
    grad = X' * (h-Y);  
    H = X' * diag(h) * diag(1-h) * X;  
   
    theta_new = theta_new - H\grad;%use \ to H^-1*grad            
end  
  
theta_new  
  
plot_X = [X(:,2)];  
plot_Y = (-1./theta_new(3)).*(theta_new(2).*plot_X +theta_new(1));  
plot(plot_X, plot_Y)  
legend('Label 1', 'Label 2', 'Decision Boundary')  
hold off  