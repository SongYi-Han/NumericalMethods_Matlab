%% parameters
fun1 = @(x) x.^2-9;
fun2 = @(x) (x-4).^2; 
fun3 = @(x) tanh(x);
dfun1 = @(x) 2*x;
dfun2 = @(x) 2*x - 8;
dfun3 = @(x) 1 - tanh(x).^2;
x0_fun1 = 0.1;
x0_fun2 = 0.1;
x0_fun3 = 2.0;
itMax = 1000;
eps = 5*10^-9;

%% run newtonmethod
[x_fun1, r_fun1, it_fun1, xxs_fun1] = NewtonMeth(fun1, dfun1, x0_fun1, itMax, eps);
[x_fun2, r_fun2, it_fun2, xxs_fun2] = NewtonMeth(fun2, dfun2, x0_fun2, itMax, eps);
[x_fun3, r_fun3, it_fun3, xxs_fun3] = NewtonMeth(fun3, dfun3, x0_fun3, itMax, eps);

%%
x = linspace(-2,5);
figure(1)
hold on
grid on
plot(x,fun1(x),'-b','LineWaidth', 1.5)
plot(x_fun1,fun1(x_fun1),'ob','LineWidth', 1.5)
plot(x,fun2(x),'-g','LineWidth', 1.5)
plot(x_fun2,fun2(x_fun2),'og','LineWidth', 1.5)
plot(x,fun3(x), '-m','LineWidth', 1.5)
%plot(x_fun3,fun3(x_fun3), 'om')
%axis([-2 5])
legend('f1','root f1', 'f2', 'root f2', 'f3')
savefig('FoundZeros.fig')
