function [x,it,errs] = gradmeth_P(A, b, x0, tol, itMax, P)
% Preconditioned gradient method ( generic P must be calculated )
% Stoping criteria ||r_k||/||r_0|| < eps
%
% Input : A - square matrix of a linear system Ax = b
%         b - vector b of a linear system Ax = b
%        x0 - col vector of initial guess 
% Output : errs - history of error (||r_k||/||r_0||)

        %initialize
        alpha = 1;
        x = x0; 
        r = b - A*x;
        r0= r;
        
        % if p is not given, calculate here 
        %
        
        errs=zeros(1,itMax);
        it = 0;
        err = tol+1;

    while (it < itMax && err > tol)
        it = it + 1;
        
        z = P\r;
        s = A*z;
   
        alpha = (z'*r)/(z'*s);
    
        x = x + alpha*z;
        r = r - alpha*s;
    
        err = norm(r)/norm(r0);
        errs(:,it) = err;    
    end
    errs = errs(:,it);
end
