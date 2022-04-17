function [A, B]=return_after_GNMF(trainset, testset, maxiter, num_basis)%ע�����LDAʱ����Ҫ�õ�ѵ�����Ͷ�Ӧ��ѵ����ǩ��Ϣ
   
options = [];
options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k = 7;   %% �����ڹ���ѵ����ʱ��ÿ����ѡȡ����������1
options.WeightMode = 'Binary';
W = constructW(trainset',options); %% ����Գƾ���W
D = diag(sum(W,2));%ͨ�����ƾ���W�����һ���ԽǾ���D�� ������˹����L=D-W

alpha = 10;   %% ���Ե����ò������õ���õ�Ч��

[m,n]=size(trainset);

intau=rand(m,num_basis);
intau = intau./(ones(m,1)*sum(intau,1));

intav=rand(num_basis,n);
intav = intav./(ones(num_basis,1)*sum(intav,1));

U = GNMF(trainset, maxiter, alpha, W, D, intau, intav);

U = ((U'*U)\U')';

%��ͼ--pengchen
drawMatrix(U);

A=trainset'*U;   
A=A';        

B=testset'*U;  
B=B';  