function [a,b] = Liner_regression(concentration,absorbancy,v,m)
%写一个两个参数的线性回归
%x:浓度 y:吸光度 v:梯度下降的学习速率 m:学习的次数
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

plot(concentration,absorbancy,'+');
x=0:max(concentration(:));
y=a.*x+b;
plot(x,y);

end

