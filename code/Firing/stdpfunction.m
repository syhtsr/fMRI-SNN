function F=stdpfunction(tt,fired)      %t1为突出前神经元脉冲放电时刻，t2为突触后神经元脉冲放电时刻
A=0.1;     %突触权值改变的最大值
a1=1.05;
A_=A*a1;      %突触权值改变的最小值
taud=20;  %表示突触增强和减弱时突触前后神经元放电时间间隔的范围。
    if (tt-fired<0)             %突触前神经元先放电的情况
    F=A*exp((tt-fired)/taud);    
    else                   %突触后神经元先放电的情况
    F=-A_*exp((-(tt-fired))/taud);
    end
  