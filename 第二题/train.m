function [train_result] = train(train_data_input,train_data_output,m,v)
%��������ѵ��ģ�� ֻ�����������������������������
%input
%train_data_input:ѵ��������������
%train_data_output:ѵ�������������
%m:���ѵ���Ĵ���
%v:ѵ��������
%output
%train_restult:A ģ�Ͳ��� PS_input:�����һ����Ϣ PS_output:�����һ����Ϣ

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
   E=train_data_output-(temp);%ÿһ��ʵ��ֵ��Ԥ��ֵ�����
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

