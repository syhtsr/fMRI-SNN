function f=enframe(x,win,inc)
nx=length(x(:)); %x为语音信号 win为窗 inc为帧长或窗函数
                                    %当为窗函数时，帧长为窗函数长，inc为帧移
                                    %输出结果为分帧后的数组，长度为帧长和帧数的乘积
nwin=length(win);
if (nwin == 1)
len = win;
else
len = nwin;
end
if (nargin < 3)
inc = len;
end
nf = fix((nx-len+inc)/inc);
f=zeros(nf,len);
indf= inc*(0:(nf-1)).';
inds = (1:len);
f(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:));
if (nwin > 1)
w = win(:)';
f = f .* w(ones(nf,1),:);
end