function[ X Y Y_d]=SD(x0)
tic
G=[21 4;4 15];
%G=[21 4;4 15];
b=[2 3]';
c=10;
%x=[x1;x2]
f=@(x)0.5*(x'*G*x) + b'*x+c;%目标函数
f_d=@(x)G*x+b;%一阶导数
%设定终止条件
N=100;E=10^(-6);
n=1;
e=norm(abs(f_d(x0)));%x0为一个随机的初始点 如[1,1],求该点的梯度
X=x0;Y=f(x0);Y_d=e;  %初始点的x y 梯度
syms a real
while n<N &&e>E
    n=n+1;
    f1=f(x0-a*f_d(x0));%作梯度下降 再求出下降后的函数输出 a为未知量 
                       %f1为关于a的一个函数
    temp=diff(f1,'a',1);%temp为f1的求导 diff
    a0=solve(temp);%solve为求解代数方程temp=0的解  
    a0=double(a0);
    x0=x0-a0*f_d(x0);
    X(:,n)=x0;Y(n)=f(x0);
    e=norm(abs(f_d(x0)));
    Y_d(n)=e;
end
toc
figure(1)
subplot(2,1,1)
semilogy(Y,'r*')
title(['函数最优值：' num2str(Y(n))])
ylabel('f(x)')
xlabel('迭代次数')
subplot(2,1,2)
semilogy(Y_d,'g<')
ylabel('f''(x)')
xlabel('迭代次数')
%title(['导函数最优值：'num2str(Y_d(n))])
figure(2)
x1=-110:1:110;y1=x1;
[X1 Y1]=meshgrid(x1,y1);
nn=length(x1);
Z1=zeros(nn.nn);
for i=1:nn
    Z1(i,j)=f([x1(i,j);y1(i,j)]);
end

hold on

contour(x1,y1,z1)
plot(x(1,:),x(2,:),'o-','linewidth',1)
