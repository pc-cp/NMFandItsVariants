function [A, B]=return_after_NMF(trainset, testset, maxiter, num_basis) %注意调用LDA时得需要用到训练集和对应的训练标签信息


[m,n]=size(trainset);       %m and n are the number of rows and columns of the trainset matrix, respectively
                            %trainset(m-by-n)

intau=rand(m,num_basis);    %intau(m-by-num_basis)
intau = intau./(ones(m,1)*sum(intau,1)); %??

intav=rand(num_basis,n);    %intav(num_basis-by-n)
intav = intav./(ones(num_basis,1)*sum(intav,1));%??


%使用训练集参与NMF，得到基础矩阵
[XfromUMultiplyV, U] = NMF(trainset, maxiter, intau, intav); %return basis matrix

%画图--pengchen
drawMatrix(U);

U = ((U'*U)\U')';           

A=trainset'*U;   
A=A';                       %A：The coefficient matrix corresponding to the trainset，本质上是NMF函数中的V？
%画图--pengchen


%****************************
drawFirstColumnForMatrix(trainset);         %数据集的第一列
drawFirstColumnForMatrix(A);                %系数矩阵的第一列
drawFirstColumnForMatrix(XfromUMultiplyV);  %U*V构建的人脸
%****************************


B=testset'*U;               
B=B';                       %B：The coefficient matrix corresponding to testset