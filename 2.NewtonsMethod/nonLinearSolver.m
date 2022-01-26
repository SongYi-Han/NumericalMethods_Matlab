%% Define given parameters
fun3 = @(x) tanh(x);
dfun3 = @(x) 1 - tanh(x).^2;
itMax = 3;
eps = 5*10^-9;
x0 = -1;
x1 = 2;

%% run

r = Bisection(fun3, x0, x1, eps, itMax)

%% Write Bisection method function

function x = Bisection(fun, a, b, tol, Max_it)
    err = abs(a-b);
    it = 1;
    if fun(a)*fun(b)<0
        while((it <= Max_it) && (err > tol))
            mid = abs(a-b)/2;   
            if fun(a)*fun(mid) < 0 
                b = mid;
            elseif fun(a)*fun(mid) > 0 
                a = mid;
            else 
                x = mid;
                break
            err = abs(a-b)/2;
            end
            it = it +1;
        end 
        x = mid;
    else fun(a)*fun(b) == 0
        x = mid;
    end
end
