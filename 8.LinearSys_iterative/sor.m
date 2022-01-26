function [x,iter,errs] = SOR(A,b,x0,nmax,tol,omega)
    % Function implementing the SOR iterative method
    
    % build P
    D = diag(diag(A));
    E = -tril(A,-1);
    P = (D - omega*E)/omega;
    invP = inv(P);

    % Initialize    
    x = x0;
    r = b-A*x;
    
    errs = zeros(1,itMax);
    iter = 0;
    err = tol+1;
    
    % Processing the iteration method
    while (err > tol) && (iter < nmax)
        iter = iter + 1;
        
        z = invP*r;
        x = x + z;
        r = b - A*x;
        
        % Stopping criterion
        err = norm(z)/norm(b);
        
        errs = errs(iter);        
    end
    errs = errs(1,1:iter); 
end



