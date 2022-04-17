function [A, B]=return_after_GNMF(trainset, testset, maxiter, num_basis)%注意调用LDA时得需要用到训练集和对应的训练标签信息
   
options = [];
options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k = 7;   %% 等于在构造训练集时，每类中选取的样本数减1
options.WeightMode = 'Binary';
W = constructW(trainset',options); %% 构造对称矩阵W
D = diag(sum(W,2));%通过相似矩阵W构造出一个对角矩阵D， 拉普拉斯矩阵L=D-W

alpha = 10;   %% 可以调整该参数，得到最好的效果

[m,n]=size(trainset);

intau=rand(m,num_basis);
intau = intau./(ones(m,1)*sum(intau,1));

intav=rand(num_basis,n);
intav = intav./(ones(num_basis,1)*sum(intav,1));

U = GNMF(trainset, maxiter, alpha, W, D, intau, intav);

U = ((U'*U)\U')';

%画图--pengchen
drawMatrix(U);

A=trainset'*U;   
A=A';        

B=testset'*U;  
B=B';  