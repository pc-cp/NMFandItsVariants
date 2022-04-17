function W = AGLGNMF(X, lambda, maxiter, r)

[m,n] = size(X);

W = rand(m,r);
W = W./(ones(m,1)*sum(W,1));

H = rand(r,n);
H = H./(ones(r,1)*sum(H,1));

S = rand(n,n);
S = S./(ones(n,1)*sum(S,1));
S(logical(eye(size(S)))) = 0;

C = (S+S')./2;
B = diag(sum(C,2));

for j=1:maxiter
  
     W = W.*((X*H')./(W*H*H'+1e-9));
     S = S.*((X'*X)./(X'*X*S+1e-9));
     S(logical(eye(size(S)))) = 0;  % 使矩阵S的主对角线上的元素全为零   
     C = (S+S')./2;
     B = diag(sum(C,2)); 
     H = H.*((W'*X+lambda*H*C)./(W'*W*H+lambda*H*B+1e-9));
     
end
end


