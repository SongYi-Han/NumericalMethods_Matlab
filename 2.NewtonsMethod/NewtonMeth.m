function [x, r, it, xxs] = NewtonMeth(fun, dfun, x0, itMax, eps)

err = abs(fun(x0));
xxs = [x0];
it = 0;

while(err>eps && it<=itMax)
    x1 = x0 - fun(x0)/dfun(x0);
    err = abs(x1-x0); % Absolute distance between the last iterations
    x0 = x1;          % New becomes old
    it = it+1;
    xxs=[xxs,x1];     % Adding to the end of the list    
end
if (err<eps)
    fprintf('Convergence obtained with %d iteration and error %e \n', it, err)
else
    fprintf('Not converged with %d iteration and error %e \n', it, err)
end

x = x1;
r = abs(fun(x1));
