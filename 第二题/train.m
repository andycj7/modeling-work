function [train_result] = train(train_data_input,train_data_output,m,v)
%函数用于训练模型 只能用于但变量的输出
%input
%train_data_input:训练集的输入数据
%train_data_output:训练集的输出数据
%m:最大训练的次数
%v:训练的速率
%output
%train_restult:A 模型参数 PS_input:输入归一化信息 PS_output:输出归一化信息

[train_data_input,PS1]=mapminmax(train_data_input',0,1);
train_data_input=train_data_input';
[train_data_output(:,1),PS2]=mapminmax(train_data_output(:,1)',0,1);
train_data_output(:,1)=train_data_output(:,1)';
A=[1,1,1,1,1,1];
for i=1:m
   E=train_data_output(:,1)-(train_data_input*A(:,1:5)'+A(:,6));
   d_A=-(E'*train_data_input+sum(E))/size(train_data_output,1);
   A=A-v*[d_A,-sum(E)/size(train_data_output,1)];
   if(sum(abs(A))<0.0001)
       break
   end
end
train_result=struct();
train_result.A=A;
train_result.PS_input=PS1;
train_result.PS_output=PS2;
end

