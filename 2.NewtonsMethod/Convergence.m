%% Reset everything
clear all; close all; clc; 

%% parameters
fun1 = @(x) x.^2-9;
dfun1 = @(x) 2*x;
x0_fun1 = 0.1;

fun2 = @(x) (x-4).^2; 
dfun2 = @(x) 2*x - 8;
x0_fun2 = 0.1;

itMax = 1000;
eps = 5*10^-9;

%% Calculate needed parameters with newtonMethod
[x_fun1,r_fun1, it_fun1, xxs_fun1] = NewtonMeth(fun1, dfun1, x0_fun1, itMax, eps);
[x_fun2,r_fun2, it_fun2, xxs_fun2] = NewtonMeth(fun2, dfun2, x0_fun2, itMax, eps);

%% (d) - with function2
% plot to find the convergence rate order for f2
[err_k, err_k1, conv_k] = cvg2(it_fun2, xxs_fun2, x_fun2);
p1 = conv_k;
p2 = (conv_k).^2;
p3 = (conv_k).^3;
p4 = (conv_k).^4;

figure(1)
loglog(err_k, err_k1, 'r-', 'LineWidth', 2)
hold on 
loglog(conv_k,p1, 'b--', 'LineWidth', 1.2)
loglog(conv_k,p2, 'g--', 'LineWidth', 1.2)
loglog(conv_k,p3, 'm--', 'LineWidth', 1.2)
loglog(conv_k,p4, 'c--', 'LineWidth', 1.2)
legend('error', 'p=1', 'p=2', 'p=3', 'p=4')

%% (d) - with function1

[err_k, err_k1, conv_k] = cvg2(it_fun1, xxs_fun1, x_fun1);

p1 = conv_k;
p2 = (conv_k).^2;
p3 = (conv_k).^3;
p4 = (conv_k).^4;

figure(2)
loglog(err_k, err_k1, 'r-', 'LineWidth', 2)
hold on 
loglog(conv_k,p1, 'b--', 'LineWidth', 1.2)
loglog(conv_k,p2, 'g--', 'LineWidth', 1.2)
loglog(conv_k,p3, 'm--', 'LineWidth', 1.2)
loglog(conv_k,p4, 'c--', 'LineWidth', 1.2)
legend('error', 'p=1', 'p=2', 'p=3', 'p=4')


%savefig('PlotConvF2');


%% Define a function to calculate error

function [err_k, err_k1, conv_k] = cvg2(it, xxs, x)
    errs = [];
    convs = [];
    for k = 1:it-1 
        err = abs(xxs(k) - x);
        errs = [errs, err];
    end
    err_k = errs(1:end-1);
    err_k1 = errs(2:end);
    conv_k = errs(1:end);
end
