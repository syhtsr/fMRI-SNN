clc;
clear;
Folders1=dir('语音数据\train\f1\09*.sph');
Folders2=dir('语音数据\train\f2\09*.sph');
Folders3=dir('语音数据\train\f3\09*.sph');
Folders4=dir('语音数据\train\f4\09*.sph');
Folders5=dir('语音数据\train\f5\09*.sph');
Folders6=dir('语音数据\train\f6\09*.sph');
Folders7=dir('语音数据\train\f7\09*.sph');
Folders8=dir('语音数据\train\f8\09*.sph');
Folders=[Folders1;Folders2;Folders3;Folders4;Folders5;Folders6;Folders7;Folders8];
path1='语音数据\train\f1\';
path2='语音数据\train\f2\';
path3='语音数据\train\f3\';
path4='语音数据\train\f4\';
path5='语音数据\train\f5\';
path6='语音数据\train\f6\';
path7='语音数据\train\f7\';
path8='语音数据\train\f8\';
path=[path1;path2;path3;path4;path5;path6;path7;path8];
len=length(Folders);
pa=1;q=1;fq=0;
for k=1:len 
    CF=0;
    df=2;
    if pa>4  
        pa=1;
        q=q+1;
    end
while CF<1
    filename=Folders(k).name;  
    pathname=[path(q,:),filename];
    [x,fs]=audioread(pathname);
    %端点检测
    [x1,x2] = vad(x);
    input=x((x1*100):(x2*100));
%lyon耳模型预处理
    LY=LyonPassiveEar(input,fs,df,4,.124);%%df和4都可以改动
    S=size(LY,2);
    P=size(LY,1);

%归一化
    m1=[];
    mm=[];
    for i=1:P
        m1(i,:)=mapminmax(LY(i,:),0,1);%幅度
        XM=S*0.3;
        [mm(i,:),b]=resample(m1(i,:),500,S);%长度%%归一化到500，也可以改600等
    end
    T=size(mm,1);

%fir低通滤波器
    fil = fir1(25,0.08,'low');

%BSA 
    N=size(mm,2);
    M=size(fil,2);
    threshold=1;
    output=[];
    for t=1:T
       for i=1:N
          error1=0;
          error2=0;
          for j=1:M
             if i+j-1<=N
               error1=error1+abs(mm(t,i+j-1)-fil(j));
               error2=error2+abs(mm(t,i+j-1));
             end       
          end
          if error1<=(error2-threshold)
             output(t,i)=1;
             for j=1:M
                if i+j-1<=N
                   mm(t,i+j-1)=mm(t,i+j-1)+fil(j);
                end
             end
          else
             output(t,i)=0;
          end
       end
    end

   CF=1;
   FF=sum(sum(output));%脉冲数量
if FF<5000 %脉冲数量小于5000，更换df再循环%%自动调节df，也可以去掉这段直接设置df的值
    CF=0;
    df=df+1;
end
end
T0=zeros(P,500);%放电时刻
for i=1:P
    m=1;
    for j=1:size(output,2)
       if output(i,j)>0
         T0(i,m)=j;
         m=m+1;
       end
    end
end
ZT0(k,:,:)=T0;%%%%%%%%%%%%%存储所有输入放电时刻%%%%%%
if FF>10000&&k>1
    ZT0(k,:,:)=ZT0(k-1,:,:);
    fq=fq+1;
end
pa=pa+1;
end

save ZT0

