function [test_result] = test(test_data_input,test_data_output,train_result)
%测试模型的正确性
%input
%test_data_input:测试数据的输入
%test_data_output:测试数据的输出
%train_result
%output
%test_result:y:模型预测输出 e:预测输出与实际输出的误差
test_data_input=mapminmax('apply',test_data_input',train_result.PS_input)';

%test_data_output=mapminmax('apply',test_data_output',train_result.PS_output);

test_result.y=test_data_input*(train_result.A(:,1:5))'+train_result.A(:,6);
test_result.y=mapminmax('reverse',test_result.y',train_result.PS_output)';
test_result.e=test_result.y-test_data_output(:,1);

end

