clc;
clear all

%% (a)

%Define the parameters
fun_l = @(x) 0.05*sin(1000*x)+0.5*cos(pi*x)-0.4*sin(10*x);

x_nodes = linspace(0,1,50);
y_nodes = fun_l(x_nodes);

figure(1)
hold on 

% plot the data points and linear piecewise interpolation
plot(x_nodes, y_nodes, 'ko')
plot(x_nodes, y_nodes, 'k-')

%% (c) - Plot Least Square Approximation

%define the parameters for leastSquare function 
xxs= x_nodes';
yys= fun_l(xxs);
m = 6;

% call the function and get the coefficient of least square polynomial

aas = leastSquares(xxs, yys, m)


% reshape the aas for the polyval and prepare the evaluation values
a = flip(aas');
x_eval = linspace(0,1,100);
y_eval_ls = polyval(a,x_eval);

plot(x_eval, y_eval_ls, 'r')

%% (d) - Plot Spline and 15th interpolation curve

% spline
y_eval_s = spline(x_nodes, y_nodes, x_eval);
plot(x_eval, y_eval_s, 'b')

% 15 order polynomial interpolation
p15_coeff = polyfit(x_nodes, y_nodes, 15);
y_eval_p15 = polyval(p15_coeff, x_eval);

plot(x_eval, y_eval_p15, 'g')
hold off
legend('data point', 'linear piecewise', 'least square', 'spline', '15th order polynomial')
savefig('PlotLS.fig')

%% (e) - print norm2 of the least square residual (RSS)

fun_l = @(x) 0.05*sin(1000*x)+0.5*cos(pi*x)-0.4*sin(10*x);

x_nodes = linspace(0,1,50);
y_nodes = fun_l(x_nodes);


x_nodes = linspace(0,1,50);
y_eval_ls = polyval(a,x_nodes); % a = coefficient vector from LS

residual = y_nodes - y_eval_ls;
rrs = (norm(residual))^2;

fprintf('The norm2 of the least square residual is %f \n', rrs)  

