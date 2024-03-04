
function F=istdpfunction(t1,t2)
c=0.02; 
p=1.5;
q=-1;
taud=20; %%%%%决定突触前后脉冲间隔的变化
% tpre=20;
% tpost=20;
    if (t1-t2<0)
    F=c*q*exp((t1-t2)/taud);
else
    F=c*p*exp((-(t1-t2))/taud);
    end
