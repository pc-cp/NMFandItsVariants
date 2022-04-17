function  W=lnmf(V, maxiter, intau, intav)

% performs Local NMF  :  local nonnegative matrix factorization
%ע��˴��ľ���V�д洢�������ǰ����еķ�ʽ������ݣ�������V�е�ÿһ��Ϊһ�����ݵ㣬���е�����Ϊ�����ݵ��ά��

% Check that whether we have non-negative data or not ? 
% if min(V(:))<0, error('Negative values in data!'); end %ʹ��min(V(:))���������V�е���Сֵ�������жϸ�ֵ�Ƿ�С���㣬��С�������ӡ��������ʾ��

% Globally rescale data to avoid potential overflow/underflow
% V = V/max(V(:)); %��ʹ��max(V(:))���������V�е����ֵ����������V�е�����Ԫ�ض����Ը�ֵ����ֹ����̫�������

% Dimensions
vdim = size(V,1); %�������V��ÿ�����ݵ��ά��
rdim = size(intau,2);
% Create initial matrices
W=intau;
H=intav;
% W = rand(vdim,rdim);%��ʼ��W����ʹ��abs���������ӱ�׼��̬�ֲ���W��С�����Ԫ��ȡ����ֵ��ʹ��WΪ�Ǹ�����
% H = rand(rdim,samples);%��ʼ��H����ʹ��abs���������ӱ�׼��̬�ֲ���H��С�����Ԫ��ȡ����ֵ��ʹ��HΪ�Ǹ�����

% Make sure W has unit sum columns!
% W = W./(ones(vdim,1)*sum(W,1));    %��Ҫ��W�е�ÿ�е�Ԫ��֮�͵���1

iter = 0;
while iter<maxiter

    iter = iter+1;    
    % Update rules (Matlab code by Stan Li) 
    
    VC = V./(W*H+1e-9);
    H = sqrt(H.*(W'*VC));
    W = W.*(VC*H')./(repmat(sum(W,2),[1,rdim]) +repmat(sum(H',1),[vdim,1])+1e-9);
    W = W./(ones(vdim,1)*sum(W,1));
end