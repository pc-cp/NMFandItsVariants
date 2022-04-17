function main()
     
    clear all; close all; clc;
    tic;    %tic、toc结合使用来记录该程序执行的时间
    addpath('Face dataset');

    maxiter = 400;  %% 指明在矩阵分解中迭代的总次数
    nRounds = 1;   %% 指明随机构造训练集和测试集的重复次数
    
    load ORL_32x32; %% 此处是把维数为1024的ORL数据集导进来做实验，在换成其他数据集时，需要修改此处
    nClass = length(unique(gnd));       %得到所使用的数据集的类别数(不同人数)  
    spliting_number = 1;                 %下面降维是从5：5：120，包含24种情况


   
    percent_NMF = zeros(nRounds,spliting_number);   %percent_NMF(5-by-24)
   
%     percent_LNMF = zeros(nRounds,spliting_number);
% 
     percent_GNMF= zeros(nRounds,spliting_number);
% 
%     percent_AGLGNMF = zeros(nRounds,spliting_number);  
    
    
    mean_accuracy_NMF = zeros(1,spliting_number);     %mean of accuracy_NMF
    std_NMF = zeros(1,spliting_number);               %

%     mean_accuracy_LNMF=zeros(1,spliting_number);
%     std_LNMF=zeros(1,spliting_number);
% 
     mean_accuracy_GNMF=zeros(1,spliting_number);
     std_GNMF=zeros(1,spliting_number);
% 
%     mean_accuracy_AGLGNMF=zeros(1,spliting_number);
%     std_AGLGNMF=zeros(1,spliting_number);
%     
   

%% Scale the features (pixel values) to [0,1]
maxValue = max(max(fea));
fea = fea/maxValue;


dataset=fea';           %dataset(m-by-n) where m means features, n means numbers of images
label=gnd;              %label : numbers of images, 列向量


 midnum=0;              %迭代器下标   
 tr_ns_perclass = 7;  %% 每类中随机选取tr_ns_perclass幅图像构造训练集，同时将每类中剩下的样本用来构造测试集
 fprintf('[trainset]the number of samples per class is:%d...\n', tr_ns_perclass);
 

for num_basis=49:5:49 %% 降低的维数包含了24种情况，从维数为5开始，步长为5，一直到120维
    fprintf('the reduction dimensionality is:%d...\n', num_basis);
    midnum=midnum+1;
     
    for t=1:nRounds     %对每个维度而言，进行5次实验然后求平均
        fprintf('Round:%d...\n', t);
        %～代表忽略对应的输出参数，这里是忽略 train_label
        [trainset, testset, ~, test_label,trainIdx,testIdx]=randselection(dataset, label, tr_ns_perclass);  %% 随机构造训练集和测试集
        % % % 
        
        %A, B correspond to the coefficient matrices of the training and test sets, respectively
        %A(num_basis-by-n)
        %B(num_bsisi-by-(rest)), rest = number of images-n
        [A,B] = return_after_NMF(trainset, testset, maxiter, num_basis);
        %将本次得到的准确率放在percent_NMF(t,midnum)中，即关于维数midnum的第t次实验得到的数据
        percent_NMF(t,midnum)=calculate_percent(A, B, label, testset, test_label, trainIdx, nClass);
        
        % % 
        %  [A, B]=return_after_LNMF(trainset, testset, maxiter, num_basis);
        %  percent_LNMF(t,midnum)=calculate_percent(A, B, label, testset, test_label, trainIdx, nClass);

        % [A, B]=return_after_GNMF(trainset, testset, maxiter, num_basis);
        % percent_GNMF(t,midnum)=calculate_percent(A,B,label,testset,test_label,trainIdx,nClass);


        %% 为自适应图学习的图正则非负矩阵分解代码，用来做人脸识别实验。上面的NMF、LNMF和GNMF是用来作比较的代码
        %[A, B]=return_after_AGLGNMF(trainset, testset, maxiter, num_basis);
        %percent_AGLGNMF(t,midnum)=calculate_percent(A,B,label,testset,test_label,trainIdx,nClass);

    end
end 
% 保存 percent_NMF指定的结构体数组的变量或字段到文件名为percent_NMF.mat的文件中 
save ('percent_NMF.mat','percent_NMF');

%如果A是一个矩阵，mean(A)将其中的各列视为向量，把矩阵中的每列看成一个向量，返回一个包含每一列所有元素的平均值的行向量。https://blog.csdn.net/wonengguwozai/article/details/51611270
mean_accuracy_NMF=mean(percent_NMF(:,:));
%若x是matrix，则y是个vector，存放的是算每一列/行的标准偏差。  std (x, flag,dim)   https://blog.csdn.net/qinze5857/article/details/79156555
std_NMF=std(percent_NMF(:,:));

save ('mean_accuracy_NMF.mat','mean_accuracy_NMF');
save ('std_NMF.mat','std_NMF');
% 
% save ('percent_LNMF.mat','percent_LNMF');
% mean_accuracy_LNMF=mean(percent_LNMF(:,:));
% std_LNMF=std(percent_LNMF(:,:));
% save ('mean_accuracy_LNMF.mat','mean_accuracy_LNMF');
% save ('std_LNMF.mat','std_LNMF');

% 
%  save ('percent_GNMF.mat','percent_GNMF');
%  mean_accuracy_GNMF=mean(percent_GNMF(:,:));
%  std_GNMF=std(percent_GNMF(:,:));
%  save ('mean_accuracy_GNMF.mat','mean_accuracy_GNMF');
%  save ('std_GNMF.mat','std_GNMF');


% save ('percent_AGLGNMF.mat','percent_AGLGNMF');
% mean_accuracy_AGLGNMF=mean(percent_AGLGNMF(:,:));
% std_AGLGNMF=std(percent_AGLGNMF(:,:));
% save ('mean_accuracy_AGLGNMF.mat','mean_accuracy_AGLGNMF');
% save ('std_AGLGNMF.mat','std_AGLGNMF');
 toc
end
