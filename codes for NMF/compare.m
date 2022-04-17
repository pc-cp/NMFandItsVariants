%{
reddimtrainset: 训练集对应的系数矩阵
reddimtestset : 测试集对应的系数矩阵
%}
function Index=compare(reddimtrainset,reddimtestset,trainIdx)  %注意trainIdx指的是训练样本在整个数据库中实际存放的位置


%得到相应系数矩阵的维数
[mTr,nTr]=size(reddimtrainset);
[mTs,nTs]=size(reddimtestset);

%按列遍历测试集
for i=1:nTs
    %取出测试集中第i列给y
    y=reddimtestset(:,i);
    %对每一个y而言，都按列遍历训练集
    for j=1:nTr        
        dist_err(j)=norm(y-reddimtrainset(:,j),2);      %n = norm(v,p) 返回广义向量 p-范数,此处为2-范数，即欧几里德长度。
    end
    [val,min_index]=min(dist_err);
    IndexFromTrain(i)=trainIdx(min_index);
end
Index=IndexFromTrain';  %Index(rest-by-1), Index(i):代表在训练集系数矩阵中与测试集第i个图像的系数矩阵"距离最小"的图像k的绝对位置
                        %这样我们就假设Index(i)：k所对应的类别和训练集i对应的类别相同，后面将会对训练集i真正的类别进行对比(猜的？)
         
        