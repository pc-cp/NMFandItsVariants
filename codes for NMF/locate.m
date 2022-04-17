function ID=locate(gnd);
%   ȷ��ĳһ�����ݵ���ʼ��ż���Ӧ�����ݸ���
%  Input
%           gnd-----class label vector.Ϊ�������ݿ������������ǩ��Ϣ,�ڱ�������ָ����label_orl
% Output
%           ID with the following elements:
%                       startN---start  number
%                       endN---end number
%                       totalN---total number
%       ID(nclass-by-3)
%

n=unique(gnd);                  %�õ���ʹ�õ����ݼ��������(��ͬ����),������ -pc
nl=length(n);                   %������ʵ�� -pc
%fprintf('The total class number is %d\n',nl);
ID=zeros(nl,3);
for i=1:nl
    %�ҵ���i���������ݼ��е�ͼ�����λ�ã�ind Ϊ������
    ind=find(gnd==i);
    
    %Ϊʲô������û���⣿��Ϊ��i���˵ı�������ݼ����ǰ��������е�
    ID(i,1)=ind(1);%��i��õ�һ�����ݱ�š���ע�����ݱ�Ų�ͬ�����
    ID(i,2)=ind(end); %��i������һ�����ݱ��
    ID(i,3)=length(ind);% ��i�����ݵĸ���
end
    