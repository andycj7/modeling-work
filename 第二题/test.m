function [test_result] = test(test_data_input,test_data_output,train_result)
%����ģ�͵���ȷ��
%input
%test_data_input:�������ݵ�����
%test_data_output:�������ݵ����
%train_result
%output
%test_result:y:ģ��Ԥ����� e:Ԥ�������ʵ����������
test_data_input=mapminmax('apply',test_data_input',train_result.PS_input)';

%test_data_output=mapminmax('apply',test_data_output',train_result.PS_output);

test_result.y=test_data_input*(train_result.A(:,1:5))'+train_result.A(:,6);
test_result.y=mapminmax('reverse',test_result.y',train_result.PS_output)';
test_result.e=test_result.y-test_data_output(:,1);

end

