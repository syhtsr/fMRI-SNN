clear;
clc;

load H1_GG_90 %拓扑包

N=90; %网络节点个数
% tmax=310;
% tspan=1:tmax;
M=77;
N=90;
load First90-4
firstin=BC;

%___Izhikevich神经元模型的参数，改变a,b,c,d的值可以改变神经元的兴奋性或抑制性
a=0.02;b=0.2;c=-65;d=8;%兴奋性神经元参数才（RS）
aa=0.02;bb=0.25;cc=-65;dd=2;%抑制性神经元参数(LTS)
EE=0;
EI=-70;
IE=5;
II=2;
%A0=rand(N,1);生成两种频率的泊松输入时用
A1=rand(N,1);
A2=rand(N,1);
xfm1=0;
xfm2=0;
%第一层
for i1=1:N
    if A1(i1)<=0.8
        a1(i1)=a;
        b1(i1)=b;
        c1(i1)=c;
        d1(i1)=d;
        E1(i1)=EE;
        Iex1(i1)=IE;
        xfm1=xfm1+1;
        B1(xfm1)=i1;
    else 
       a1(i1)=aa;
        b1(i1)=bb;
        c1(i1)=cc;
        d1(i1)=dd;  
        E1(i1)=EI;
        Iex1(i1)=II;
    end
end

% tau=0.5;
% tau1=5;
gmin=0;gmax=0.015;
gin=0.05;
n1=zeros(N,1);  %计数第1层N个神经元的放电次数
n11=zeros(N,1);
n2=0;
T1array=zeros(N,200);%存储第1层N个神经元的放电时刻
T2array=[];
%___输出层的电位值
VV2=[];
%___突触电导初值
% 第0层和第1层之间的突触电导值
for i1=1:N
    for i0=1:M
        g0(i0,i1,1)=0;%.015*rand(1);          %电导初值,i0表示泊松输入层，i1表示第一层（前，后，仿真时间）
    end
end       
% 第1层之间的突触电导值
for j1=1:N
    for i1=1:N
        if GG(i1,j1)~=0
           g1(i1,j1,1)=0; 
           s(i1,j1,1)=1;%电导初值
           o(i1,j1,1)=0;
           h(i1,j1)=round(random('Poisson',20));  %%%设置随机时滞

        end
          if i1==j1
            g1(i1,j1,1)=0; 
           s(i1,j1,1)=1;%电导初值
           o(i1,j1,1)=0;  
          end
    end
end 

%第1层和第2层之间的突触电导值
for i2=1:N
    g2(i2,1)=0;
end
for i1=1:N                   %第1层神经元
    V1(i1,1)=-65;
    u1(i1,1)=b1(i1)*V1(i1,1);
    T1(i1)=5+round(10*rand(1));   
end

%输出层神经元--输出层
V2(1)=-65;
u2(1)=b*V2(1);
T2=25+round(10*rand(1));
%___以上为初始化部分，首先将此部分程序运行，得到初始化的值，然后将运行的值保存为.mat.保证每次运行程序时，网络的初始情况是相同的。

 save netdata