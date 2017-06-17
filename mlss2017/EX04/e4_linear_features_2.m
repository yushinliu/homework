clear;
load('data2Class.txt');
figure(1);clf;hold on; 
plot3(data2Class(:,1),data2Class(:,2),data2Class(:,3),'r.');

n = size(data2Class,1);
X =data2Class(:,1:2)
X = [ones(n,1),X]
Y = data2Class(:,3);
beta= zeros (3,1)
lambda = 0;
I = eye(3)

for k =1:10
    p =exp(- X*beta)+1
    p = 1./p
    u=(1-p)*p'
    W = diag(diag(u))
    derivative_beta = X'*(p-Y)+2*lambda*I*beta
    sencondderi_beta = X'*W*X +2*lambda*I
    beta = beta - sencondderi_beta\ derivative_beta
end    
%splot [-2:3][-2:3][-3:3.5] ¡¯model¡¯ matrix \
%us ($1/20-2):($2/20-2):3 with lines notitle
[a b] = meshgrid(-2:.1:3,-2:.1:3)
Xgrid = [a(:),b(:)];
Z =exp(-Xgrid*beta)+1
Z = 1./Z
Ygrid = Z
Ygrid = reshape(Ygrid,size(a));
h = surface(a,b,Ygrid);
view(3);
%plot [-2:3][-2:3] ¡¯data2Class.txt¡¯ \
%us 1:2:3 with points pt 2 lc variable title ¡¯train¡¯
figure(2);
% plot it 
pos = find(Y == 1); neg = find(Y == 0);
plot(X(pos, 2), X(pos,3), 'g+')  
hold on  
plot(X(neg, 2), X(neg, 3), 'r+')  
hold on  
xlabel('axis X')  
ylabel('axis Y')
plot_X = [X(:,2)]; 
plot_Y = (-1./beta).*(beta.*plot_X +beta); %X2=-(beta1*X1+beta0)/beta2 
plot(plot_X, plot_Y)  
legend('Label 1', 'Label 2', 'Decision Boundary')  
hold off 