clear;
clc;

load F %��Ԫ�ŵ�
len=size(F,1); 
So=zeros(len,600);
l=size(F,3); 


% �����ʼȨ��
load  g0%%%%%0��Ȩ��
Woi0=g0;
load  g1%%%%1��Ȩ��
Woi1=g1;
load  g2%%%%2��Ȩ��
Woi2=g2;
load  g3%%%%3��Ȩ��
Woi3=g3;
 load  g4%%%%%4��Ȩ��
Woi4=g4;
load  g5%%%%5��Ȩ��
Woi5=g5;
load  g6%%%%6��Ȩ��
Woi6=g6;
load  g7%%%%7��Ȩ��
Woi7=g7;
load  g8%%%%8��Ȩ��
Woi8=g8;
load  g9%%%%9��Ȩ��
Woi9=g9;

%%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%
a=0.02;
b=0.2;
c=-65;
d=8;
tau=0.5;
n2=0;
V2(1)=-65;
u2(1)=-13;
n=0;
V1(1)=-65;
u1(1)=-13;
V3(1)=-65;
u3(1)=-13;
V4(1)=-65;
u4(1)=-13;
V5(1)=-65;
u5(1)=-13;
V6(1)=-65;
u6(1)=-13;
V7(1)=-65;
u7(1)=-13;
V8(1)=-65;
u8(1)=-13;
V9(1)=-65;
u9(1)=-13;
V0(1)=-65;
u0(1)=-13;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%ѧϰ����%%%%%%%%%%%
for m=1:len
    %���㵱ǰȨ���µ�ʵ�����
    TTarray0=[];
    VV0=[];
    So0=zeros(1,600);
    for t=2:l
        I0(t)=sum(Woi0(:,t).*F(m,:,t)')*1000;
        V0(t)=V0(t-1)+tau*(0.04*(V0(t-1))^2+5*V0(t-1)+140-u0(t-1)+I0(t));
        u0(t)=u0(t-1)+tau*a*(b*V0(t-1)-u0(t-1));
        if V0(t)>=30  
           VV0(end+1)=30;
           V0(t)=c;
           u0(t)=u0(t)+d;
           T0=t;
%            n=n+1;
           TTarray0=[TTarray0,T0];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So0(t)=1;                   %ʵ�������������
        else
           VV0(end+1)=V0(t);
        end
    end
    
    TTarray1=[];
    VV1=[];
    So1=zeros(1,600);
    for t=2:l
        I1(t)=sum(Woi1(:,t).*F(m,:,t)')*1000;
        V1(t)=V1(t-1)+tau*(0.04*(V1(t-1))^2+5*V1(t-1)+140-u1(t-1)+I1(t));
        u1(t)=u1(t-1)+tau*a*(b*V1(t-1)-u1(t-1));
        if V1(t)>=30  
           VV1(end+1)=30;
           V1(t)=c;
           u1(t)=u1(t)+d;
           T1=t;
%            n=n+1;
           TTarray1=[TTarray1,T1];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So1(t)=1;                   %ʵ�������������
        else
           VV1(end+1)=V1(t);
        end
    end
  
    
    TTarray2=[];
    VV2=[];
    So2=zeros(1,600);
    for t=2:l
        I2(t)=sum(Woi2(:,t).*F(m,:,t)')*1000;
        V2(t)=V2(t-1)+tau*(0.04*(V2(t-1))^2+5*V2(t-1)+140-u2(t-1)+I2(t));
        u2(t)=u2(t-1)+tau*a*(b*V2(t-1)-u2(t-1));
        if V2(t)>=30  
           VV2(end+1)=30;
           V2(t)=c;
           u2(t)=u2(t)+d;
           T=t;
%            n=n+1;
           TTarray2=[TTarray2,T];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So2(t)=1;                   %ʵ�������������
        else
           VV2(end+1)=V2(t);
        end
    end
    
TTarray3=[];
    VV3=[];
    So3=zeros(1,600);
    for t=2:l
        I3(t)=sum(Woi3(:,t).*F(m,:,t)')*1000;
        V3(t)=V3(t-1)+tau*(0.04*(V3(t-1))^2+5*V3(t-1)+140-u3(t-1)+I3(t));
        u3(t)=u3(t-1)+tau*a*(b*V3(t-1)-u3(t-1));
        if V3(t)>=30  
           VV3(end+1)=30;
           V3(t)=c;
           u3(t)=u3(t)+d;
           T3=t;
%            n=n+1;
           TTarray3=[TTarray3,T3];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So3(t)=1;                   %ʵ�������������
        else
           VV3(end+1)=V3(t);
        end
    end

TTarray4=[];
    VV4=[];
    So4=zeros(1,600);
    for t=2:l 
        I4(t)=sum(Woi4(:,t).*F(m,:,t)')*1000;
        V4(t)=V4(t-1)+tau*(0.04*(V4(t-1))^2+5*V4(t-1)+140-u4(t-1)+I4(t));
        u4(t)=u4(t-1)+tau*a*(b*V4(t-1)-u4(t-1));
        if V4(t)>=30  
           VV4(end+1)=30;
           V4(t)=c;
           u4(t)=u4(t)+d;
           T4=t;
%            n=n+1;
           TTarray4=[TTarray4,T4];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So4(t)=1;                   %ʵ�������������
        else
           VV4(end+1)=V4(t);
        end
    end
    
        TTarray5=[];
    VV5=[];
    So5=zeros(1,600);
    for t=2:l 
        I5(t)=sum(Woi5(:,t).*F(m,:,t)')*1000;
        V5(t)=V5(t-1)+tau*(0.04*(V4(t-1))^2+5*V5(t-1)+140-u5(t-1)+I5(t));
        u5(t)=u5(t-1)+tau*a*(b*V5(t-1)-u5(t-1));
        if V5(t)>=30  
           VV5(end+1)=30;
           V5(t)=c;
           u5(t)=u5(t)+d;
           T5=t;
%            n=n+1;
           TTarray5=[TTarray5,T5];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So5(t)=1;                   %ʵ�������������
        else
           VV5(end+1)=V5(t);
        end
    end
        
        TTarray6=[];
    VV6=[];
    So6=zeros(1,600);
    for t=2:l
        I6(t)=sum(Woi6(:,t).*F(m,:,t)')*1000;
        V6(t)=V6(t-1)+tau*(0.04*(V6(t-1))^2+5*V6(t-1)+140-u6(t-1)+I6(t));
        u6(t)=u6(t-1)+tau*a*(b*V6(t-1)-u6(t-1));
        if V6(t)>=30  
           VV6(end+1)=30;
           V6(t)=c;
           u6(t)=u6(t)+d;
           T6=t;
%            n=n+1;
           TTarray6=[TTarray6,T6];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So6(t)=1;                   %ʵ�������������
        else
           VV6(end+1)=V6(t);
        end
    end
    
    TTarray7=[];
    VV7=[];
    So7=zeros(1,600);
    for t=2:l
        I7(t)=sum(Woi7(:,t).*F(m,:,t)')*1000;
        V7(t)=V7(t-1)+tau*(0.04*(V7(t-1))^2+5*V7(t-1)+140-u7(t-1)+I7(t));
        u7(t)=u7(t-1)+tau*a*(b*V7(t-1)-u7(t-1));
        if V7(t)>=30  
           VV7(end+1)=30;
           V7(t)=c;
           u7(t)=u7(t)+d;
           T7=t;
%            n=n+1;
           TTarray7=[TTarray7,T7];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So7(t)=1;                   %ʵ�������������
        else
           VV7(end+1)=V7(t);
        end
    end
   
    TTarray8=[];
    VV8=[];
    So8=zeros(1,600);
    for t=2:l
        I8(t)=sum(Woi8(:,t).*F(m,:,t)')*1000;
        V8(t)=V8(t-1)+tau*(0.04*(V8(t-1))^2+5*V8(t-1)+140-u8(t-1)+I8(t));
        u8(t)=u8(t-1)+tau*a*(b*V8(t-1)-u8(t-1));
        if V8(t)>=30  
           VV8(end+1)=30;
           V8(t)=c;
           u8(t)=u8(t)+d;
           T8=t;
%            n=n+1;
           TTarray8=[TTarray8,T8];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So8(t)=1;                   %ʵ�������������
        else
           VV8(end+1)=V8(t);
        end
    end
    TTarray9=[];
    VV9=[];
    So9=zeros(1,600);
    for t=2:l 
        I9(t)=sum(Woi9(:,t).*F(m,:,t)')*1000;
        V9(t)=V9(t-1)+tau*(0.04*(V9(t-1))^2+5*V9(t-1)+140-u9(t-1)+I9(t));
        u9(t)=u9(t-1)+tau*a*(b*V9(t-1)-u9(t-1));
        if V9(t)>=30  
           VV9(end+1)=30;
           V9(t)=c;
           u9(t)=u9(t)+d;
           T9=t;
%            n=n+1;
           TTarray9=[TTarray9,T9];        %�����Ԫ��ʵ�ʷŵ�ʱ��
           So9(t)=1;                   %ʵ�������������
        else
           VV9(end+1)=V9(t);
        end
    end
 len0=length(TTarray0);   
len1=length(TTarray1);
len2=length(TTarray2);
len3=length(TTarray3);
len4=length(TTarray4);
len5=length(TTarray5);
len6=length(TTarray6);
len7=length(TTarray7);
len8=length(TTarray8);
len9=length(TTarray9);

if max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len0
   Panbie(m)=0;
elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len1
   Panbie(m)=1;
   elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len2
   Panbie(m)=2;
   elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len3
   Panbie(m)=3;
   elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len4
   Panbie(m)=4;
   elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len5
   Panbie(m)=5;
   elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len6
   Panbie(m)=6;
   elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len7
   Panbie(m)=7;
   elseif max([len0,len1,len2,len3,len4,len5,len6,len7,len8,len9])==len8
   Panbie(m)=8;
else
   Panbie(m)=9; 
end
    end
