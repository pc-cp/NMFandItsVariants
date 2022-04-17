function ID=locate(gnd);
%   确定某一类数据的起始编号及对应的数据个数
%  Input
%           gnd-----class label vector.为整个数据库所有类的类别标签信息,在本程序中指的是label_orl
% Output
%           ID with the following elements:
%                       startN---start  number
%                       endN---end number
%                       totalN---total number
%       ID(nclass-by-3)
%

n=unique(gnd);                  %得到所使用的数据集的类别数(不同人数),列向量 -pc
nl=length(n);                   %人数，实数 -pc
%fprintf('The total class number is %d\n',nl);
ID=zeros(nl,3);
for i=1:nl
    %找到第i个人在数据集中的图像绝对位置，ind 为列向量
    ind=find(gnd==i);
    
    %为什么这样做没问题？因为第i个人的编号在数据集中是按升序排列的
    ID(i,1)=ind(1);%第i类得第一个数据编号。。注意数据编号不同与类别
    ID(i,2)=ind(end); %第i类得最后一个数据编号
    ID(i,3)=length(ind);% 第i类数据的个数
end
    
