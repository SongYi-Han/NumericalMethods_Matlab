function [Q,R] = qrsolve(A)
% QR decompostion via Gram-Schmidt process 
% input : A (square matrix)
% output : Q (orthogonal matrix)
%          R (upper triangualr matrix)

    % Step 1) Calculate matrix Q
    [N_r,N_c] = size(A);
    U = zeros(N_r,N_r);    % initialize u vectors
    Q = zeros(N_r,N_r);    % initialize matrix Q

    for j = 1:N_r
        % find U matrix col
        if j == 1 
            U(:,j) = A(:,j);
        else
            U(:,j) = A(:,j);  
            for i = 1:j-1
                U(:,j) = U(:,j) - (sum(U(:,i).*A(:,j)))/(sum(U(:,i).*U(:,i)))*U(:,i);
            end
        end
        % update matrix Q 
        Q(:,j) = U(:,j)/norm(U(:,j));
    end
    % Step 2) Calculate matrix R
    R = Q'*A;
    % make R upper triangular matrix
    R = triu(R);
    
end
