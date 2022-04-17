function U = GNMF(X, maxiter, alpha, W, D, intau, intav)
% Graph Regularized  nonnegative matrix factorization for Data Representation. PAMI 2011                         
%%     This code solves the following problem 
%           ||X-U*V||+alpha*tr(VLV')         s.t. U>=0,V>=0;
%        where X( m-by- n), U( m-by- k), V( k-by- n)
%  Input:
%      X -  Each column is a sample point.
%      gnd - Label matrix.
%      k - The number wanted to factorized
% Written by Xin Shu. ahjmsshx AT sjtu.edu.cn
% 31/10/2011. Version 1. 

U=intau;
V=intav;

for j=1:maxiter
     U=U.*((X*V')./(U*V*V'+1e-9));
     V=V.*((U'*X+alpha*V*W+1e-9)./(U'*U*V+alpha*V*D+1e-9));
end
%  normmatrix=diag(1./(sqrt(sum(U.^2,1))));
%  ubest=U*normmatrix;
%  vbest=normmatrix*V;
%  U=ubest;

