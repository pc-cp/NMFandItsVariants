function [A, B]=return_after_AGLGNMF(trainset, testset, maxiter, num_basis) 

lambda =10;   % ����ͨ�������˲��������÷�����7-9����

U = AGLGNMF(trainset, lambda, maxiter, num_basis); 

U = ((U'*U)\U')';  % ͨ������£���ѧϰ����ͶӰ����U���б��κ����ù���ʹ��

A=trainset'*U;   %�õ�ͶӰ����U������ѵ�������н�ά
A=A';        %��Ϊ������compare������ʹ�õ��ǰ��д洢ͼ��,ÿһ�д��һ��ͼ�����Դ˴�Ҫת��

B=testset'*U;  %ͬ�����Բ��Լ�Ҳ��ѧϰ����ͶӰ����U���н�ά
B=B';  