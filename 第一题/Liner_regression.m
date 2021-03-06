function [a,b,test] = Liner_regression(concentration,absorbancy,v,m)
%写一个两个参数的线性回归
%input:x:浓度 y:吸光度 v:梯度下降的学习速率 m:学习的次数
%output:a,b系数 test：显著性检验的参数 
a=1;
b=1;
for i=1:m
    e=absorbancy-(concentration*a+b);
    d_a=(-2*concentration'*e)/size(absorbancy,1);
    d_b=(-2*sum(e))/size(absorbancy,1);
    if(abs(d_a)<0.0001&&abs(d_b)<0.0001)
       break;
    end
    a=a-v*d_a;
    b=b-v*d_b;
end
a=roundn(a,-4);
b=roundn(b,-4);
%绘图
plot(concentration,absorbancy,'+');
hold on;
x=0:max(concentration(:));
y=a.*x+b;
plot(x,y);
%F发布 显著性检验
test=struct();
yk_mean=mean(absorbancy);
test.TSS=sum((absorbancy-yk_mean).^2);
test.ESS=sum((a*concentration+b-yk_mean).^2);
test.RSS=sum((absorbancy-a*concentration-b).^2);
test.F=test.ESS/(test.RSS/(size(absorbancy,1)-2));
test.alpha=0.02;
test.F_alpha=finv(1-test.alpha,1,size(absorbancy,1)-2);
if(test.F>test.F_alpha)
    test.result=1;
else
    test.result=0;
end
end

