function drawMatrix(W)
%DRAWBASISMATRIX 此处显示有关此函数的摘要
%   此处显示详细说明

%{
W是数据集矩阵(m-by-n)
每一列是一张图像通过拼接而成，而该图像的维度是多少要根据具体数据集而定，总维度为m
该数据集一共有n张图像
%}
[m,n]=size(W);

dimension = sqrt(length(W(:,1)));
fprintf('The dimensions of each image are [equal in length and width]:%d\n', dimension);

%按列遍历测试集
for i = 1:n
    x = W(:,i);     %取出第i个图像给x
    %这里将x还原成该图像的矩阵，维数要根据不同数据集而改变，这里ORL是32x32
    
    y = reshape(x, [dimension, dimension]);
    
    %将n个图像画成一个方形，其中每个元素都是一张图像，必须保证n是某个整数的平方
    picturedim = sqrt(n);   
    subplot(picturedim, picturedim, i);
    
    %figure, imshow(mat2gray(y));
    imshow(mat2gray(y));
    
    hold on;
    
  

    
    
    
%     if i > 0
%         break;
%     end
end

end

