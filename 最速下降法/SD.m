function[ X Y Y_d]=SD(x0)
tic
G=[21 4;4 15];
%G=[21 4;4 15];
b=[2 3]';
c=10;
%x=[x1;x2]
f=@(x)0.5*(x'*G*x) + b'*x+c;%Ŀ�꺯��
f_d=@(x)G*x+b;%һ�׵���
%�趨��ֹ����
N=100;E=10^(-6);
n=1;
e=norm(abs(f_d(x0)));%x0Ϊһ������ĳ�ʼ�� ��[1,1],��õ���ݶ�
X=x0;Y=f(x0);Y_d=e;  %��ʼ���x y �ݶ�
syms a real
while n<N &&e>E
    n=n+1;
    f1=f(x0-a*f_d(x0));%���ݶ��½� ������½���ĺ������ aΪδ֪�� 
                       %f1Ϊ����a��һ������
    temp=diff(f1,'a',1);%tempΪf1���� diff
    a0=solve(temp);%solveΪ����������temp=0�Ľ�  
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
title(['��������ֵ��' num2str(Y(n))])
ylabel('f(x)')
xlabel('��������')
subplot(2,1,2)
semilogy(Y_d,'g<')
ylabel('f''(x)')
xlabel('��������')
%title(['����������ֵ��'num2str(Y_d(n))])
figure(2)
x1=-110:1:110;y1=x1;
[X1 Y1]=meshgrid(x1,y1);
nn=length(x1);
Z1=zeros(nn,nn);
for i=1:nn
    for j=1:nn
        Z1(i,j)=f([X1(i,j);Y1(i,j)]);
    end
end

hold on

contour(X1,Y1,Z1)
plot(X1(1,:),X1(2,:),'o-','linewidth',1)
