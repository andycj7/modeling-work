function [test_result] = test(test_data_input,test_data_output,train_result)
%测试模型的正确性 能测试五个输入参数 两个输出参数的模型
%input
%test_data_input:测试数据的输入
%test_data_output:测试数据的输出
%train_result:A 模型参数 最后一个为常数项 PS_input 归一化方法信息结构体 PS_output 归一化方法信息结构体
%output
%test_result:y:模型预测输出 e:预测输出与实际输出的误差
test_data_input=mapminmax('apply',test_data_input',train_result.PS_input)';

%test_data_output=mapminmax('apply',test_data_output',train_result.PS_output);

test_result.y(:,1)=test_data_input*(train_result.A(1,1:5))'+train_result.A(1,6);
test_result.y(:,2)=test_data_input*(train_result.A(2,1:5))'+train_result.A(2,6);
test_result.y=mapminmax('reverse',test_result.y',train_result.PS_output)';
test_result.e=test_result.y-test_data_output;
test_result.e_mean=mean(test_result.e);

end

