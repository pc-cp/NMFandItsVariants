function [A, B]=return_after_NMF(trainset, testset, maxiter, num_basis) %ע�����LDAʱ����Ҫ�õ�ѵ�����Ͷ�Ӧ��ѵ����ǩ��Ϣ


[m,n]=size(trainset);       %m and n are the number of rows and columns of the trainset matrix, respectively
                            %trainset(m-by-n)

intau=rand(m,num_basis);    %intau(m-by-num_basis)
intau = intau./(ones(m,1)*sum(intau,1)); %??

intav=rand(num_basis,n);    %intav(num_basis-by-n)
intav = intav./(ones(num_basis,1)*sum(intav,1));%??


%ʹ��ѵ��������NMF���õ���������
[XfromUMultiplyV, U] = NMF(trainset, maxiter, intau, intav); %return basis matrix

%��ͼ--pengchen
drawMatrix(U);

U = ((U'*U)\U')';           

A=trainset'*U;   
A=A';                       %A��The coefficient matrix corresponding to the trainset����������NMF�����е�V��
%��ͼ--pengchen


%****************************
drawFirstColumnForMatrix(trainset);         %���ݼ��ĵ�һ��
drawFirstColumnForMatrix(A);                %ϵ������ĵ�һ��
drawFirstColumnForMatrix(XfromUMultiplyV);  %U*V����������
%****************************


B=testset'*U;               
B=B';                       %B��The coefficient matrix corresponding to testset