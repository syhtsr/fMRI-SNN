                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%主程序
clear;
clc;
 load speechdata   %语音数据
 len=size(ZT0,1);%%%size获得的是ZT0里面的第一个参数，即多少个语音
firings1=zeros(90,600);%90个神经元，600个时间长度，神经元个数改变时要更改
firings=zeros(90,600);
Fir1=zeros(len,90,600);

%___仿真过程  大循环 不同的神经元按列存储，同一个神经元的不同时刻按行存储
for k=1:len
     T0=ZT0(k,:,:);
  load netdata
gn=zeros(600,1);%存放突触的个数
gbig=zeros(600,1);%%强耦合
gsmall=zeros(600,1);%%弱耦合
gmid=zeros(600,1);%%%中等耦合
T0array=zeros(N,200); %%200列是为了存放每个神经元的放电时刻，一般是50次
T2=49;%%%在后来的第3层输出时，也想按照STDP规则来减去上一个时刻，因此这里设置一个初始时刻。但是后面好像没用到。
for t=2:600        %%从第2个时刻开始      
    %1-2层突触权重的改变 第2层神经元放电   
    for j1=1:N
        I1(j1,t)=sum((g0(:,j1,t-1).*(E1(j1)-V1(j1,t-1))))*50+sum(o(:,j1,t-1).*(E1(j1)-V1(j1,t-1)))*1;%%%50和1的倍数是可以更改的，找到最合适的放电效果，即不能全部时刻都放电或都不放电，要达到有的时刻放点有的时刻不放电那种效果
        V1(j1,t)=V1(j1,t-1)+tau*(0.04*(V1(j1,t-1))^2+5*V1(j1,t-1)+140-u1(j1,t-1)+I1(j1,t));%%%%V1和u1是Izhichevichi神经元放电公式
        u1(j1,t)=u1(j1,t-1)+tau*a1(j1)*(b1(j1)*V1(j1,t-1)-u1(j1,t-1));
        if V1(j1,t)>=30 
            V1(j1,t)=c1(j1);
            u1(j1,t)=u1(j1,t)+d1(j1);
            n11(j1)=n11(j1)+1;               %放电次数
            T1(j1)=t;
            T1array(j1,n11(j1))=T1(j1);         %存放电时间
            Fir1(k,j1,t)=1;%%Fir1里面存的是网络内部神经元的放电时刻得到的0和1的序列
        end
        %1-2层
        for i0=1:77
           if any(firstin(i0,:)==j1)%%%firstin在前面load的数据包里是77*4个，把语音脉冲给到4个神经元，比如对应神经元编号1时。找到与i0相连的神经元j1
             if any(T0(1,i0,:)==t)%%%T0中的第1个语音的第i0个序列在这个时刻是否放电
                g0(i0,j1,t)=gmax;%%%有放电脉冲则设置g0为gmax
             else
                g0(i0,j1,t)= 0;%%无放电脉冲则设置g0为0
             end
          
                if g0(i0,j1,t) <gmin%%%%%%这下面这一段是为了把g0控制在gmin到gmax这个范围内
                    g0(i0,j1,t)=gmin;
                end
                if g0(i0,j1,t)>gmax
                    g0(i0,j1,t)=gmax;
                end
           else
               g0(i0,j1,t)=0;
           end
        end

    %第2层内部神经元%%%按照构建的脉冲神经网络规则%%这里的网络按照新网络的构建
%     for j1=1:N
        for i1=1:N
            if GG(i1,j1)==0
                   g1(i1,j1,t)=0;
                   s(i1,j1,t)=0;
                   o(i1,j1,t)=0;
            else 

                index01=find(T1array(i1,:)>0&T1array(i1,:)<=t&abs(T1array(i1,:)-T1(j1))<20); %满足最邻近原则的放电时刻%%考虑神经元i1对j1的影响，若j1的上一个紧邻i1的放电时刻间隔大于0小于20则认为i1对j1产生影响
             %find函数把所有产生影响的时刻位置存在index01中
                if isempty(index01)%如果index01为空，则没有产生影响的突触前神经元
                     g1(i1,j1,t)= g1(i1,j1,t-1)-(tau/tau1)*g1(i1,j1,t-1);%突触后神经元没有接到突出前神经元的电流
                else    %%%突触后神经元接收到突触前神经元的电流
                    f1=min(abs(T1array(i1,index01(:))-T1(j1))); %%%%找到最小值%%%找到前后神经元放电时刻最近的放电时刻
                    m1=find(abs(T1array(i1,index01(:))-T1(j1))==f1);%找到最小值的位置
                    %%%%%%%%%%%%%%%具有时滞的突触%%%%%%%%%%
                    if (d1(i1)==8)    %d1是兴奋性神经元参数设置为8，初始化程序里有
                         g1(i1,j1,t)=g1(i1,j1,t-1)+gmax*stdpfunction(T1array(i1,m1(1)),T1(j1)); %按照兴奋性突触可塑性改变                       
                        if t<h(i1,j1)+3 
                         o(i1,j1,t)=0;
                         else
                         s(i1,j1,t-h(i1,j1)-1)=s(i1,j1,t-h(i1,j1)-2)+(((2*t2function(V1(i1,t-h(i1,j1)-2))*(1-s(i1,j1,t-h(i1,j1)-2)))-s(i1,j1,t-h(i1,j1)-2)));
                         o(i1,j1,t)=g1(i1,j1,t)*s(i1,j1,t-h(i1,j1)-1);  
                        end 
                    else
                        g1(i1,j1,t)=g1(i1,j1,t-1)+gmax*istdpfunction(T1array(i1,m1(1)),T1(j1)); %按照抑制性突触可塑性进行改变
                         if t<h(i1,j1)+3
                            o(i1,j1,t)=0;
                         else
                            s(i1,j1,t-h(i1,j1)-1)=s(i1,j1,t-h(i1,j1)-2)+(((0.9*t2function(V1(i1,t-h(i1,j1)-2))*(1-s(i1,j1,t-h(i1,j1)-2)))-0.1*s(i1,j1,t-h(i1,j1)-2)));
                            o(i1,j1,t)=g1(i1,j1,t)*s(i1,j1,t-h(i1,j1)-1);
                         end
                    end
                     
                end
             
                %--------------关于g的计算-------------------%是为了得到突触权值的动态变化过程
                      gn(t)=gn(t)+1;             
                     if g1(i1,j1,t)>= (0.9*gmax)%%%满足这个条件称为强耦合突触，得到gbig(t)
                         gbig(t)=gbig(t)+1;
                     else if g1(i1,j1,t)<= (0.1*gmax)%%%满足这个条件称为弱耦合突触，得到gsmall(t)
                             gsmall(t)=gsmall(t)+1;
                         else
                             gmid(t)=gmid(t)+1;%%%其余的都属于中等耦合突触
                         end
                     end
                %----------------------------------------%以上得到的三个值可以用来绘图突触电导的动态变化
             end
                        if g1(i1,j1,t) <gmin
                         g1(i1,j1,t)=gmin;
                         end
                         if g1(i1,j1,t)>gmax 
                         g1(i1,j1,t)=gmax;
                         end
        end
       
        
    end  

end

end

     MM=[];
     for n=1: 90
       for ta=1:600
          if Fir1(1,n,ta)>0
             MM=[MM;n,ta];
          end
       end
    end
    figure;
    plot(MM(:,2),MM(:,1),'.K');
    

 save Fir1 %放电结果
