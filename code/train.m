clear;
clc;

Sd=zeros(1,600);                 
% Td=[6	17	96	104	121	100	110	101	124	127	132	146	138	293	314	331	301	372	402	305	339	335	321	310	320	319	312	313	350	155]
%目标序列
for i=1:length(Td)
    Sd(Td(i))=1;
end
%导入输入
load Fir1
len=240;%训练数据集个数
F=zeros(len,600);
N=90;%改节点个数
W=5e-4; 
Woi=ones(N,600).*W;
g0=Woi;
% Woi=g2;

%%%%%%%%%%%%%%%%参数设置%%%%%%%%%%%%%%%%
a=0.02;
b=0.2;
c=-65;
d=8;
n2=0;
V2(1)=-65;
u2(1)=-13
n=0;
V(1)=-65;
u(1)=-13;
Adi=2e-6;
taudi=5;
A=2.35;
taux=1e-5;
IE=4;
EE=0;
tau=0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% So=zeros(100,600);%最终输出
%%%%%%%%%学习过程%%%%%%%%%%%
for m=1:len
    %计算当前权重下的实际输出
    TTarray=[];
    VV=[];
    So0=zeros(1,600);
    for t=2:600 
        I(t)=sum(Woi(:,t).*Fir1(m,:,t)')*1000;%%这还神经元公式，但是此时电流依赖的是初始权重，将初始权重点乘输入序列
        V(t)=V(t-1)+tau*(0.04*(V(t-1))^2+5*V(t-1)+140-u(t-1)+I(t));
        u(t)=u(t-1)+tau*a*(b*V(t-1)-u(t-1));
        if V(t)>=30  
           VV(end+1)=30;
           V(t)=c;
           u(t)=u(t)+d;
           T=t;
%            n=n+1;
           TTarray=[TTarray,T];        %输出神经元的实际放电时刻%%%用初始权重得到的此时实际输出放电时刻
           So0(t)=1;                   %实际输出脉冲序列%%%%转化为实际输出0和1序列
        else
           VV(end+1)=V(t);
        end
    end
  
g2_sum=g0(:,1);                 %初始时刻权重
q1=zeros(N,1);
T2array=[];                     %最终放电时刻
VV2=[];
for t=2:600 
    %RuSuMe%%%%%开始进行算法训练
    for i=1:N                                
        for s=1:600
            dt=taux*log(A);
            k=t-s;%%%%这个算法公式分开来看，积分里面的部分是一个卷积过程
          
            if k<=0%%%%卷积是其中一个翻转后前移再相乘，所取得时间限是大于0的部分
               Si=0;
            else
               Si=Fir1(m,i,k);%%%%Si获得实际输入Fir1
            end         
            adi(i,s)=Adi*exp(-s/taudi);
            f(i,s)=adi(i,s)*Si;
        end
        xx=1:600;
        q1(i,t)=trapz(xx,f(i,:));%%%%算卷积的函数，积分部分算完

        dd=(Sd(t)-So0(t))*(aa+q1(i,t))*1000;%%%实际输出和目标输出
        if dd~=0  %&&dd>0
           mm=1; 
        end
           Woi(i,t)=Woi(i,t)+dd;%%%公式的左边是权重微分，写成差分形式，把前一时刻的移到公式右边，则现在时刻的权重就是上一时刻加dd
    end
    
    g2_sum=Woi(:,t);%%%获得了训练后的权重
    I2(t)=sum(g2_sum.*Fir1(m,:,t)')*1000;%%再用训练后的权重加到第三层中运行
    V2(t)=V2(t-1)+tau*(0.04*(V2(t-1))^2+5*V2(t-1)+140-u2(t-1)+I2(t));
    u2(t)=u2(t-1)+tau*a*(b*V2(t-1)-u2(t-1));
    if V2(t)>=30  
       VV2(end+1)=30;
       V2(t)=c;
       u2(t)=u2(t)+d;
       T2=t;
%        n2=n2+1;
       T2array=[T2array,T2];        %输出神经元的放电时刻%%%得到了使用训练后权重跑出来的放电时刻
       F(m,t)=1;                    %实际输出转化为0和1的脉冲序列
    else
       VV2(end+1)=V2(t);
    end
    
end
g0=Woi;%%%经过训练的权重
end

I1=F;
SM=[];               
for n=1:len
   for ta=1:600
      if I1(n,ta)>0
         SM=[SM;n,ta];
      end
   end
end
figure;

plot(SM(:,2),SM(:,1),'.K');

 save g0