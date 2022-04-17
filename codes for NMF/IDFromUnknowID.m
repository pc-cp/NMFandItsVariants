%{
unknowID(rest-by-1), rest = number of images in testset
ID(nClass-by-3),    nClass 是数据集中的人数
%}

function ind=IDFromUnknowID(unknowID,ID,nClass)
%  对于给定的一个数据标号，确定其类别（第一类，第二类，.....)
%   Usage(使用方法):  unknowID=1335, gnd=3,即第1335个数据来自第3类。
% Input 
%             unknowID------------由算法计算的数据标号。unknowID(i) = j,
%             算法认为图像i与测试集中图像j的类别相同
%             ID------------------真实数据的ID，调用ID=locate（gnd），具体看locate的函数,即图像i真正对应类别为图像ID(i,1)~ID(i,2)所属类别
%             nClass-----------数据类别数
%  Output
%             ind----------给定不用标号的数据其对应的ID

% Written by shuxin at sjtu---ahjmsshx At sjtu.edu.cn
%
%

x=unknowID;
n=length(x);
ind=zeros(n,1);

%将测试集第i个图像通过算法得到的在其训练集中图像最接近对应的图像位置x(i)与每个类别在数据集的范围进行比较，
%得到测试集中第i个图像的标签，目的还是基于算法的结果的进一步细化
for i=1:n
% ID=locate(gnd);% gnd 为真实的数据标记
    for j=1:nClass      %   nClass为类别数目
        startN=ID(j,1); %   第j类数据开始的位置
        endN=ID(j,2);   %   第j类数据结束的位置
        if(x(i)>=startN&x(i)<=endN)
            ind(i)=j;   %   哪个第i个图像属于类别j的照片吼
            break
        end
    end
end

