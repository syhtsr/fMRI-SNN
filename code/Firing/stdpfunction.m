function F=stdpfunction(tt,fired)      %t1Ϊͻ��ǰ��Ԫ����ŵ�ʱ�̣�t2Ϊͻ������Ԫ����ŵ�ʱ��
A=0.1;     %ͻ��Ȩֵ�ı�����ֵ
a1=1.05;
A_=A*a1;      %ͻ��Ȩֵ�ı����Сֵ
taud=20;  %��ʾͻ����ǿ�ͼ���ʱͻ��ǰ����Ԫ�ŵ�ʱ�����ķ�Χ��
    if (tt-fired<0)             %ͻ��ǰ��Ԫ�ȷŵ�����
    F=A*exp((tt-fired)/taud);    
    else                   %ͻ������Ԫ�ȷŵ�����
    F=-A_*exp((-(tt-fired))/taud);
    end
  