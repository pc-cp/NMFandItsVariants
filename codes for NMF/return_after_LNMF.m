function [A, B]=return_after_LNMF(trainset, testset, maxiter, num_basis)%ע�����LDAʱ����Ҫ�õ�ѵ�����Ͷ�Ӧ��ѵ����ǩ��Ϣ

[m,n]=size(trainset);
intau=rand(m,num_basis);
intau = intau./(ones(m,1)*sum(intau,1));

intav=rand(num_basis,n);
intav = intav./(ones(num_basis,1)*sum(intav,1));

[U] = lnmf(trainset, maxiter, intau, intav);

U = ((U'*U)\U')';

A=trainset'*U;   
A=A';        


B=testset'*U;  
B=B';  