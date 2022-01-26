%% Initialize 
clc; clear all;

%% Define the conditions 

fun = @(x) x.*cos(x) - (x-2).^2 -1;

x_nodes_h1 = linspace(0,5,11)';     % col vector, h1 = 0.5
y_nodes_h1 = fun(x_nodes_h1);      % col vector

x_nodes_h2 = linspace(0,5,21)';     % col vector, h1 = 0.25
y_nodes_h2 = fun(x_nodes_h2);      % col vector

x_nodes_h3 = linspace(0,5,41)';     % col vector, h1 = 0.125
y_nodes_h3 = fun(x_nodes_h3);      % col vector

x_eval = linspace(0.5,4.5,100);  % x points to evaluate
y_eval = fun(x_eval)


%% find v(x) value for every different h

coeff_h1 = naturalspline(x_nodes_h1, y_nodes_h1); 
interval_h1 = x_nodes_h1';
pp_h1 = mkpp(interval_h1, coeff_h1);
y_eval_h1 = ppval(pp_h1,x_eval);

coeff_h2 = naturalspline(x_nodes_h2, y_nodes_h2); 
interval_h2 = x_nodes_h2';
pp_h2 = mkpp(interval_h2, coeff_h2);
y_eval_h2 = ppval(pp_h2,x_eval);

coeff_h3 = naturalspline(x_nodes_h3, y_nodes_h3); 
interval_h3 = x_nodes_h3';
pp_h3 = mkpp(interval_h3, coeff_h3);
y_eval_h3 = ppval(pp_h3,x_eval);


%% calculate norm2 of v(x) and f(x) ( = errors)

err_diff_h1 = y_eval_h1 - y_eval;
err_diff_h2 = y_eval_h2 - y_eval;
err_diff_h3 = y_eval_h3 - y_eval;

err_h1 = norm(err_diff_h1)
err_h2 = norm(err_diff_h2)
err_h3 = norm(err_diff_h3)

%% Define convergence with order p = 2 3 4 5
fun_p2 = @(x) x.^2
fun_p3 = @(x) x.^3
fun_p4 = @(x) x.^4
fun_p5 = @(x) x.^5

h = [0.125 0.25 0.5]
errors = [err_h3, err_h2, err_h1]

%% plot error and convergences by h 

figure(1)
loglog(h, errors, 'LineWidth', 2)
hold on
loglog(h, fun_p2(h), '--', 'LineWidth', 2)
loglog(h, fun_p3(h), '--', 'LineWidth', 2)
loglog(h, fun_p4(h), '--', 'LineWidth', 2)
loglog(h, fun_p5(h), '--', 'LineWidth', 2)
hold off

legend('error', 'p2','p3','p4','p5')
