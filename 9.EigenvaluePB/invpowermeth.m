function [lambda, xx, iter] = invpowermethod(A, x0, tol, itMax)
x = x0;
y = x0/norm(x0);
invA = inv(A);
mu = y'*invA*y;

err = tol+1;
iter = 0;

while (err > tol) && (iter < itMax)
    x = invA*y;
    y = x/norm(x);
    
    mu_pr = mu; % save previous mu 
    mu = y'*(invA*y); %y'*x; 
    
    err = abs(mu - mu_pr);
    iter = iter+1;
end

xx = y; % eigen vextor
lambda = 1/mu; % smallest eigen value 
end


