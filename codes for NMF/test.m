function V = test(X, maxiter,nClass)
[m,n] = size(X);
W = rand(m,90);
W = W./(ones(m,1)*sum(W,1));

H = rand(90,n);
H = H./(ones(90,1)*sum(H,1));

S = rand(n,n);
S = S./(ones(n,1)*sum(S,1));
S(logical(eye(size(S)))) = 0;

C = (S+S')./2;
B = diag(sum(C,2));

for i = 1:maxiter
    
    %% using Euclidean distance 
    W = W.*((X*H')./(W*H*H'+1e-9));
    S = S.*((X'*X)./(X'*X*S+1e-9));
    S(logical(eye(size(S)))) = 0;  % 使矩阵S的主对角线上的元素全为零   
    
    C = (S+S')./2;
    B = diag(sum(C,2)); 
    
    H = H.*((W'*X+9*H*C)./(W'*W*H+9*H*B+1e-9)); 
    plot(i,trace((X-W*H)'*(X-W*H)),'m.');
    hold on;
%% using KL divergence
%     V=V.*(U'*(X./(U*V+1e-9)))./(sum(U)'*ones(1,size(X,2)));
%     U=U.*((X./(U*V+1e-9))*V')./(ones(size(X,1),1)*sum(V'));
%      Recon_Error=norm(X-U*V,'fro').^2;
%      fprintf('This is the %f th\n',i);
%      fprintf('Reconstruction Error is %10.9f\n',Recon_Error);
end
hold off;
xlabel('迭代次数');
ylabel('目标函数值');
title('迭代次数对目标的影响');
set(gca,'FontSize',15);
end