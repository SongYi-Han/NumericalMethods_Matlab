function [lambda, xx, iter, lambdas, xxs] = powershift(A, alpha, tol, itMax, x0)

% initialize
n = size(A,1);
B = A - eye(n)*alpha; % shifted matrix !!

xx = x0;
yy = xx/norm(xx,2);
lambda = yy'*xx;

lambdas = zeros(1, itMax); % eigen values
xxs = zeros(n,itMax);      % eigen vectors 

err = tol+1;
iter = 0;

while (err >= tol ) && (iter < itMax)
    iter = iter+1;
    
    % calculate the new eigenvector
    xx = B*yy;
    yy = xx/norm(xx,2);
    % calculate the new eigenvalue
    lambda_pr = lambda + alpha;
    lambda = yy'*xx;
    
    % storage of the history
    xxs(:,iter) = yy; % normalized output for eigenvector
    lambdas(iter) = lambda + alpha; % adding shift !!
    
    % calculating the error 
    err = abs(lambdas(iter)-lambda_pr); 
    % rel: abs(lambdas(iter)-lambda_pr)/abs(lambda)
    
end

lambda = lambda + alpha;
lambdas = lambdas(1:iter);
xxs = xxs(:,1:iter);
xx = yy; % normalized xx 
    
end

    
