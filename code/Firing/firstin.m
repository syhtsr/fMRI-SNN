clc;clear;
A=1:90;%神经元个数
BC=zeros(77,4);
m=1;n=1;
for i=1:77
%    h(i,:)=randi(numel(A),1,4);
   for j=1:90
      if any(A(:)==j)
        if length(find(BC(1:i,:)==j))>=m
          n=n+1;
          if n>112
             m=2; 
          end
          L=find(A(:)==j);
          A(L)=[];
          
        end 
      end
   end
   c=randperm(numel(A));
   BC(i,:)=A(c(1:10));
end
for i=1:90
   AA(i)=length(find(BC(:,:)==i)); 
end
AAA1=find(AA(:)==4);
AAA2=find(AA(:)==5);
 save firstin-90-4;