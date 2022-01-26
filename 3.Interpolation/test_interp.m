%% Reset everything 
clear all; close all; clc;

%% Define all paremeters needed in this exercise
d = 2; 
ns = [2 4 6 8 10];
nodes = node(d, ns); % needed x values based on interpolation order

xs =[]; % all points that user want to interpolate (col vector)
for j = 0:1000
    x = -2 + (2*2/1000)*j;
    xs = [xs; x];
end

%% Plot interpolation function (n = 2, 4, 6, 8, 10) and real f(x) 

fun = @(x) exp(-x.^2);

figure(1)
for i = 1:length(ns)
    n = ns(i);
    nodes = node(d,n);
    ys = exp(-(nodes).^2);
    ys = ys';
    [phi] = LagranCharPoly(nodes, xs);
    disp(size(phi));
    interpol = phi*ys;
    hold on 
    plot(xs, interpol, 'LineWidth', 2)
    %plot(nodes, fun(nodes), '*')
    
end
plot(xs, fun(xs), ':k','LineWidth', 2)
legend('n=2', 'n=4', 'n=6', 'n=8', 'n=10', 'f(x)')
xlabel('x')
ylabel('y')
title('Interpolation with different degree')
savefig('fun_interp_n')

%% Plot Error based on n
p1 = @(x) exp(-x);
p2 = @(x) exp(-2*x);
p3 = @(x) exp(-3*x);

Error_Maxs = [];

for i = 1:length(ns)
    n = ns(i);
    nodes = node(d,n);
    ys = exp(-(nodes).^2);
    ys = ys';
    [phi] = LagranCharPoly(nodes, xs);
    interpol = phi*ys;  
    xs_n = length(xs);
    errors = [];
    for j = 1:xs_n
        error = abs(fun(xs(j)) - interpol(j));
        errors = [errors error];
        Error_Max = max(errors);
    end
    Error_Maxs = [Error_Maxs Error_Max];
end

figure(2)
semilogy(ns, Error_Maxs, 'LineWidth', 2)
hold on
semilogy(ns, p1(ns), 'LineWidth', 2)
semilogy(ns, p2(ns), 'LineWidth', 2)
semilogy(ns, p3(ns), 'LineWidth', 2)
legend('E_n', 'p=1', 'p=2', 'p=3')
xlabel('n')
ylabel('log_{Max Error}')

savefig('err_interp_n')



%% Function to calculate nodes based on order

function [x_k] = node(d, n)
    x_k = [];
    for k = 0:n
        x = -d + (2*d./n).*k;
        x_k = [x_k, x];
    end
end
