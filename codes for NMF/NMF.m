function [XfromUMultiplyV, U] = NMF(X, maxiter, intau, intav)

U=intau;
V=intav;

    for i = 1:maxiter

        %% using Euclidean distance 

         U = U.*(X*V'./(U*V*V'+1e-9));
         V = V.*(U'*X./(U'*U*V+1e-9));

    end
    %drawFirstColumnForMatrix(X);
    %drawFirstColumnForMatrix(V);
    XfromUMultiplyV = U*V;
    
end
