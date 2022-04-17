function [A, B]=return_after_LNMF(trainset, testset, maxiter, num_basis)%注意调用LDA时得需要用到训练集和对应的训练标签信息

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