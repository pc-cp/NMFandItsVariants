%{
reddimtrainset: ѵ������Ӧ��ϵ������
reddimtestset : ���Լ���Ӧ��ϵ������
%}
function Index=compare(reddimtrainset,reddimtestset,trainIdx)  %ע��trainIdxָ����ѵ���������������ݿ���ʵ�ʴ�ŵ�λ��


%�õ���Ӧϵ�������ά��
[mTr,nTr]=size(reddimtrainset);
[mTs,nTs]=size(reddimtestset);

%���б������Լ�
for i=1:nTs
    %ȡ�����Լ��е�i�и�y
    y=reddimtestset(:,i);
    %��ÿһ��y���ԣ������б���ѵ����
    for j=1:nTr        
        dist_err(j)=norm(y-reddimtrainset(:,j),2);      %n = norm(v,p) ���ع������� p-����,�˴�Ϊ2-��������ŷ����³��ȡ�
    end
    [val,min_index]=min(dist_err);
    IndexFromTrain(i)=trainIdx(min_index);
end
Index=IndexFromTrain';  %Index(rest-by-1), Index(i):������ѵ����ϵ������������Լ���i��ͼ���ϵ������"������С"��ͼ��k�ľ���λ��
                        %�������Ǿͼ���Index(i)��k����Ӧ������ѵ����i��Ӧ�������ͬ�����潫���ѵ����i�����������жԱ�(�µģ�)
         
        