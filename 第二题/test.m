function [test_result] = test(test_data_input,test_data_output,train_result)
%����ģ�͵���ȷ�� �ܲ������������� �������������ģ��
%input
%test_data_input:�������ݵ�����
%test_data_output:�������ݵ����
%train_result:A ģ�Ͳ��� ���һ��Ϊ������ PS_input ��һ��������Ϣ�ṹ�� PS_output ��һ��������Ϣ�ṹ��
%output
%test_result:y:ģ��Ԥ����� e:Ԥ�������ʵ����������
test_data_input=mapminmax('apply',test_data_input',train_result.PS_input)';

%test_data_output=mapminmax('apply',test_data_output',train_result.PS_output);

test_result.y(:,1)=test_data_input*(train_result.A(1,1:5))'+train_result.A(1,6);
test_result.y(:,2)=test_data_input*(train_result.A(2,1:5))'+train_result.A(2,6);
test_result.y=mapminmax('reverse',test_result.y',train_result.PS_output)';
test_result.e=test_result.y-test_data_output;
test_result.e_mean=mean(test_result.e);

end

