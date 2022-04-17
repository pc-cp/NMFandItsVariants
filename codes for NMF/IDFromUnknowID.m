%{
unknowID(rest-by-1), rest = number of images in testset
ID(nClass-by-3),    nClass �����ݼ��е�����
%}

function ind=IDFromUnknowID(unknowID,ID,nClass)
%  ���ڸ�����һ�����ݱ�ţ�ȷ������𣨵�һ�࣬�ڶ��࣬.....)
%   Usage(ʹ�÷���):  unknowID=1335, gnd=3,����1335���������Ե�3�ࡣ
% Input 
%             unknowID------------���㷨��������ݱ�š�unknowID(i) = j,
%             �㷨��Ϊͼ��i����Լ���ͼ��j�������ͬ
%             ID------------------��ʵ���ݵ�ID������ID=locate��gnd�������忴locate�ĺ���,��ͼ��i������Ӧ���Ϊͼ��ID(i,1)~ID(i,2)�������
%             nClass-----------���������
%  Output
%             ind----------�������ñ�ŵ��������Ӧ��ID

% Written by shuxin at sjtu---ahjmsshx At sjtu.edu.cn
%
%

x=unknowID;
n=length(x);
ind=zeros(n,1);

%�����Լ���i��ͼ��ͨ���㷨�õ�������ѵ������ͼ����ӽ���Ӧ��ͼ��λ��x(i)��ÿ����������ݼ��ķ�Χ���бȽϣ�
%�õ����Լ��е�i��ͼ��ı�ǩ��Ŀ�Ļ��ǻ����㷨�Ľ���Ľ�һ��ϸ��
for i=1:n
% ID=locate(gnd);% gnd Ϊ��ʵ�����ݱ��
    for j=1:nClass      %   nClassΪ�����Ŀ
        startN=ID(j,1); %   ��j�����ݿ�ʼ��λ��
        endN=ID(j,2);   %   ��j�����ݽ�����λ��
        if(x(i)>=startN&x(i)<=endN)
            ind(i)=j;   %   �ĸ���i��ͼ���������j����Ƭ��
            break
        end
    end
end
