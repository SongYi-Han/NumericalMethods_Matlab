%% Initialize the work space
clc; clear all;
%% Define the conditions 

fun = @(x) x.*cos(x) - (x-2).^2 -1;
x_nodes = linspace(0,5,6)';  % col vector
y_nodes = fun(x_nodes);      % col vector

x_eval = linspace(0,5,100);  % x points to evaluate


%% plot evaluation points with matlab built-in spline function

y_eval_bs = spline(x_nodes, y_nodes, x_eval);

figure(1)
hold on 
plot(x_nodes, y_nodes, 'ko')
plot(x_eval, y_eval_bs, 'k--')

%% plot evaluation points with my natural spline function

coeff = naturalspline(x_nodes, y_nodes) 
y_eval_ms = [];

for interval = 1:length(x_nodes)-1
    index = find((x_nodes(interval+1) >= x_eval).*(x_nodes(interval) <= x_eval));
    index;
    
    if ~isempty(index)
        xtemp = x_eval(index) - x_nodes(interval) ;
            
        A = [xtemp.^3; xtemp.^2 ; xtemp; ones(1, length(index))];
        values = coeff(interval, :)*A;

        y_eval_ms = [y_eval_ms, values];
    end    
end

plot(x_eval, y_eval_ms, 'r')
hold off
legend('Data points (nodes)', 'Matlab Spline','My NaturalSpline')
savefig('PlotSplines.fig')

%% find the derivative of f'(X) and approximation v'(x)
fun_div = @(x) cos(x)-x.*sin(x)-2*(x-2)
y_nodes_fd = fun_div(x_nodes)

y_eval_fd = spline(x_nodes, y_nodes_fd, x_eval)

figure(2)
hold on 
plot(x_eval, y_eval_fd, 'b-')

coeff_dcb = coeff(1:end,1:end-1); 
mat3 = 3*ones(length(x_nodes)-1, 1);
mat2 = 2*ones(length(x_nodes)-1, 1);
mat1 = ones(length(x_nodes)-1, 1);
mat = [mat3 mat2 mat1];
div_coeff = coeff_dcb.*mat;

y_eval_vd = [];

for interval = 1:length(x_nodes)-1
    index = find((x_nodes(interval+1) >= x_eval).*(x_nodes(interval) <= x_eval));
    index;
    
    if ~isempty(index)
        xtemp = x_eval(index) - x_nodes(interval) ;
            
        A = [xtemp.^2 ; xtemp; ones(1, length(index))];
        values = div_coeff(interval, :)*A;

        y_eval_vd = [y_eval_vd, values];
    end    
end

plot(x_eval, y_eval_vd, 'r-')
hold off
legend('f(x) derivative', 'approximation')
savefig('PlotDerivSplines.fig')
