function [trainset, testset, train_label, test_label,trainIdx,testIdx]=randselection(dataset, label, tr_ns_perclass)

x=unique(label);                %x是label去重后的列向量，即训练集中类别数(不同的人数)
numlabel=length(x);             %numlabel是人数(实数)

[m,n] = size(dataset);          %m: 每个图像拼接后的列向量维度，n:数据集中的图像数
 trainset = zeros(m,1);         %
 testset=zeros(m,1);            %
 
ts_ns_perclass_begin = tr_ns_perclass +1;   %??tr_ns_perclass:9
llp=0;
lp=0;

    %从每个人的图像集中抽取一定数量的图像作训练集
    for i=1:numlabel
        ind=find(label==x(i));      %找到第i个人的图像在数据集中的地址下标并放在ind中存放,ind 为列向量
        rind=randperm(length(ind)); %随机生成1～length(ind)的排列组合,            rind为行向量
        %从第i个人的图像集中随机抽取tr_ns_perclass个图像组成训练集(rind前tr_ns_perclass个图像的位置)，并将这些图像在数据集中的位置存放到trainIdx这个列向量的(i-1)*tr_ns_perclass+1～i*tr_ns_perclass这个区间上
        trainIdx(((i-1)*tr_ns_perclass+1):(i*tr_ns_perclass))=ind(rind(1:tr_ns_perclass));
        %所要做的目的几乎同上，只不过这次存的是组成训练集图像的标签，大胆猜一下，如果label中的升序排，则该语句右侧等价于*i* ??
        train_label(((i-1)*tr_ns_perclass+1):(i*tr_ns_perclass))=label(ind(rind(1:tr_ns_perclass))); 
        %矩阵级联，第一列为全0，第2～tr_ns_perclass+1为抽取第1个人组成的训练集,以后就是级联拼接
        trainset=[trainset,dataset(:,ind(rind(1:tr_ns_perclass),1))];
      
        %lp:第i个人测试集中图像的数量，就是抽取训练集剩下的所有图像组成测试集
        lp=length(rind(ts_ns_perclass_begin:end));
        %下面部分同上，只不过是为了组成测试集的信息
        testIdx((llp+1):(lp+llp))=ind((rind(ts_ns_perclass_begin:end)));
        test_label((llp+1):(lp+llp))=label(ind(rind(ts_ns_perclass_begin:end)));
        llp=lp+llp;
        testset=[testset,dataset(:,ind(rind(ts_ns_perclass_begin:end),1))];

    end
 

 %去掉多余的第一列
 trainset=trainset(:,2:end);
 testset=testset(:,2:end);
 %将原来的列向量变成行向量
 train_label=train_label';
 test_label=test_label';
 trainIdx= trainIdx';
 testIdx = testIdx';
 save ('trainIdx.mat','trainIdx');
 save ('train_label.mat','train_label');
 save ('trainset.mat','trainset');
 
 save ('testIdx.mat','testIdx');
 save ('test_label.mat','test_label');
 save ('testset.mat','testset');
end