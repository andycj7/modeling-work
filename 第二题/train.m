function [train_result] = train(train_data_input,train_data_output,m,v)
%函数用于训练模型 只能用于五个输入变量，两个输出变量
%input
%train_data_input:训练集的输入数据
%train_data_output:训练集的输出数据
%m:最大训练的次数
%v:训练的速率
%output
%train_restult:A 模型参数 PS_input:输入归一化信息 PS_output:输出归一化信息

[train_data_input,PS1]=mapminmax(train_data_input',0,1);
train_data_input=train_data_input';
[train_data_output,PS2]=mapminmax(train_data_output',0,1);
train_data_output=train_data_output';
A=[1,1,1,1,1,1;
   1,1,1,1,1,1];
for i=1:m
   temp=train_data_input*A(:,1:5)';
   temp(:,1)=temp(:,1)+A(1,6);
   temp(:,2)=temp(:,2)+A(2,6);
   E=train_data_output-(temp);%每一轮实际值和预测值的误差
   temp1=E'*train_data_input;
   temp2=sum(E)';
   temp1(1,:)=temp1(1,:)+temp2(1,:);
   temp1(2,:)=temp1(2,:)+temp2(2,:);
   d_A=-(temp1)/size(train_data_output,1);
   A=A-v*[d_A,-sum(E)'/size(train_data_output,1)];
   if(sum(abs(A(1,:)))<0.0001&&sum(abs(A(2,:)))<0.0001)
       break
   end
end
train_result=struct();
train_result.A=A;
train_result.E=mean(E);
train_result.PS_input=PS1;
train_result.PS_output=PS2;
train_result.m=m;
train_result.v=v;
end

