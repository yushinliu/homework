clear;
load('data2Class.txt');
figure(1);clf;hold on; 
plot3(data2Class(:,1),data2Class(:,2),data2Class(:,3),'r.');

n = size(data2Class,1);
for k =1:n
    if data2Class(k,3)
        X(k,3:4)=data2Class(k,1:2)
    else   
        X(k,1:2)=data2Class(k,1:2)
    end
    
end
X = [ones(n,1),X]
Y = data2Class(:,3);
beta = zeros(5,1);
lambda = 0;
I = eye(5)

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
[a b] = meshgrid(-2:.1:2,-2:.1:2)
Xgrid = [ones(length(a(:)),1),zeros(length(a(:)),1),zeros(length(a(:)),1),a(:),b(:)];
Ygrid =exp(-Xgrid*beta)+1
Ygrid = 1./Ygrid
Ygrid = reshape(Ygrid,size(a));
h = surface(a,b,Ygrid);
view(3);
%plot [-2:3][-2:3] ¡¯data2Class.txt¡¯ \
%us 1:2:3 with points pt 2 lc variable title ¡¯train¡¯




