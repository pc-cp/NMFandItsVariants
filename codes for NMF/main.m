function main()
     
    clear all; close all; clc;
    tic;    %tic��toc���ʹ������¼�ó���ִ�е�ʱ��
    addpath('Face dataset');

    maxiter = 400;  %% ָ���ھ���ֽ��е������ܴ���
    nRounds = 1;   %% ָ���������ѵ�����Ͳ��Լ����ظ�����
    
    load ORL_32x32; %% �˴��ǰ�ά��Ϊ1024��ORL���ݼ���������ʵ�飬�ڻ����������ݼ�ʱ����Ҫ�޸Ĵ˴�
    nClass = length(unique(gnd));       %�õ���ʹ�õ����ݼ��������(��ͬ����)  
    spliting_number = 1;                 %���潵ά�Ǵ�5��5��120������24�����


   
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
label=gnd;              %label : numbers of images, ������


 midnum=0;              %�������±�   
 tr_ns_perclass = 7;  %% ÿ�������ѡȡtr_ns_perclass��ͼ����ѵ������ͬʱ��ÿ����ʣ�µ���������������Լ�
 fprintf('[trainset]the number of samples per class is:%d...\n', tr_ns_perclass);
 

for num_basis=49:5:49 %% ���͵�ά��������24���������ά��Ϊ5��ʼ������Ϊ5��һֱ��120ά
    fprintf('the reduction dimensionality is:%d...\n', num_basis);
    midnum=midnum+1;
     
    for t=1:nRounds     %��ÿ��ά�ȶ��ԣ�����5��ʵ��Ȼ����ƽ��
        fprintf('Round:%d...\n', t);
        %���������Զ�Ӧ����������������Ǻ��� train_label
        [trainset, testset, ~, test_label,trainIdx,testIdx]=randselection(dataset, label, tr_ns_perclass);  %% �������ѵ�����Ͳ��Լ�
        % % % 
        
        %A, B correspond to the coefficient matrices of the training and test sets, respectively
        %A(num_basis-by-n)
        %B(num_bsisi-by-(rest)), rest = number of images-n
        [A,B] = return_after_NMF(trainset, testset, maxiter, num_basis);
        %�����εõ���׼ȷ�ʷ���percent_NMF(t,midnum)�У�������ά��midnum�ĵ�t��ʵ��õ�������
        percent_NMF(t,midnum)=calculate_percent(A, B, label, testset, test_label, trainIdx, nClass);
        
        % % 
        %  [A, B]=return_after_LNMF(trainset, testset, maxiter, num_basis);
        %  percent_LNMF(t,midnum)=calculate_percent(A, B, label, testset, test_label, trainIdx, nClass);

        % [A, B]=return_after_GNMF(trainset, testset, maxiter, num_basis);
        % percent_GNMF(t,midnum)=calculate_percent(A,B,label,testset,test_label,trainIdx,nClass);


        %% Ϊ����Ӧͼѧϰ��ͼ����Ǹ�����ֽ���룬����������ʶ��ʵ�顣�����NMF��LNMF��GNMF���������ȽϵĴ���
        %[A, B]=return_after_AGLGNMF(trainset, testset, maxiter, num_basis);
        %percent_AGLGNMF(t,midnum)=calculate_percent(A,B,label,testset,test_label,trainIdx,nClass);

    end
end 
% ���� percent_NMFָ���Ľṹ������ı������ֶε��ļ���Ϊpercent_NMF.mat���ļ��� 
save ('percent_NMF.mat','percent_NMF');

%���A��һ������mean(A)�����еĸ�����Ϊ�������Ѿ����е�ÿ�п���һ������������һ������ÿһ������Ԫ�ص�ƽ��ֵ����������https://blog.csdn.net/wonengguwozai/article/details/51611270
mean_accuracy_NMF=mean(percent_NMF(:,:));
%��x��matrix����y�Ǹ�vector����ŵ�����ÿһ��/�еı�׼ƫ�  std (x, flag,dim)   https://blog.csdn.net/qinze5857/article/details/79156555
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