function  W=lnmf(V, maxiter, intau, intav)

% performs Local NMF  :  local nonnegative matrix factorization
%注意此处的矩阵V中存储的数据是按照列的方式存放数据，即矩阵V中的每一列为一个数据点，该列的行数为此数据点的维数

% Check that whether we have non-negative data or not ? 
% if min(V(:))<0, error('Negative values in data!'); end %使用min(V(:))计算出矩阵V中的最小值，并且判断该值是否小于零，若小于零则打印出错误提示。

% Globally rescale data to avoid potential overflow/underflow
% V = V/max(V(:)); %先使用max(V(:))计算出矩阵V中的最大值，并将矩阵V中的所有元素都除以该值，防止数据太大溢出。

% Dimensions
vdim = size(V,1); %计算矩阵V中每个数据点的维数
rdim = size(intau,2);
% Create initial matrices
W=intau;
H=intav;
% W = rand(vdim,rdim);%初始化W并且使用abs函数将服从标准正态分布的W中小于零的元素取绝对值，使得W为非负矩阵
% H = rand(rdim,samples);%初始化H并且使用abs函数将服从标准正态分布的H中小于零的元素取绝对值，使得H为非负矩阵

% Make sure W has unit sum columns!
% W = W./(ones(vdim,1)*sum(W,1));    %即要求W中的每列的元素之和等于1

iter = 0;
while iter<maxiter

    iter = iter+1;    
    % Update rules (Matlab code by Stan Li) 
    
    VC = V./(W*H+1e-9);
    H = sqrt(H.*(W'*VC));
    W = W.*(VC*H')./(repmat(sum(W,2),[1,rdim]) +repmat(sum(H',1),[vdim,1])+1e-9);
    W = W./(ones(vdim,1)*sum(W,1));
end
