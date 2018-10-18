
function [example_result] =example(data)
%5ÕÛ½»²æÑéÖ¤
[M,N]=size(data);
indices=crossvalind('Kfold',data(1:M,N),5);
example_result=cell(5,2);
for k=1:5
    test_1=(indices==1);
    train_1=~test_1;
    train_data=data(train_1,:);
    train_data_input=train_data(:,1:5);
    train_data_output=train_data(:,6:7);
    test_data=data(test_1,:);
    test_data_input=test_data(:,1:5);
    test_data_output=test_data(:,6:7);
    train_result= train(train_data_input,train_data_output,1000000,0.0005);
    [test_result]= test(test_data_input,test_data_output,train_result);
    example_result{k,1}=train_result;
    example_result{k,2}=test_result;
end


end

