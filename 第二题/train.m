function [train_result] = train(train_data_input,train_data_output,m,v)
%��������ѵ��ģ�� ֻ�����ڵ����������
%input
%train_data_input:ѵ��������������
%train_data_output:ѵ�������������
%m:���ѵ���Ĵ���
%v:ѵ��������
%output
%train_restult:A ģ�Ͳ��� PS_input:�����һ����Ϣ PS_output:�����һ����Ϣ

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

