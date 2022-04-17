function [A, B]=return_after_AGLGNMF(trainset, testset, maxiter, num_basis) 

lambda =10;   % 可以通过调整此参数获得最好分类结果7-9极好

U = AGLGNMF(trainset, lambda, maxiter, num_basis); 

U = ((U'*U)\U')';  % 通常情况下，对学习到的投影矩阵U进行变形后再拿过来使用

A=trainset'*U;   %得到投影矩阵U，并对训练集进行降维
A=A';        %因为后续的compare函数中使用的是按列存储图像,每一列存放一幅图像，所以此处要转置

B=testset'*U;  %同理，对测试集也用学习到的投影矩阵U进行降维
B=B';  