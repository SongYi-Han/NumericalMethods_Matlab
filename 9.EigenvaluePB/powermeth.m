function [lambda, lambdas, xx, xxs, iter] = powermethod(A, x0, tol, itMax)

n = size(A,1);

y = x0/norm(x0);
lambda = y'*A*y;

err = tol+1;
iter = 0;

xxs = zeros(n,itmax);
lambdas = zeros(1,itmax);

while (err > tol) && (iter < itMax)
    iter = iter+1;
    
    x = A*y;
    y = x/norm(x);
    
    lambda_pr = lambda; % previous lambda
    lambda = y'*A*y;    % new lambda
    
    xxs(:,iter) = y; % add history
    lambdas(iter) = lambda; % add history
    
    err = abs(lambda - lambda_pr); % rel : abs(lambda - lambda_pr)/abs(lambda)
    
end

xx = y;
lambdas = lambdas(1:iter);
xxs = xxs(:,1:iter);

end


