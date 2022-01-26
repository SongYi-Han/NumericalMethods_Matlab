%% 
clear all; close all; clc

%% 1) Assemble the matrix A and vector b
N = [200, 400, 800, 1600, 3200];

QR_tt = @(n) n.^3;
QR_sol_tt = @(n) n.^3 + n.^2;
QR_times = [];
QR_sol_times = [];

for n = 1:length(N)
     A = zeros(N(n),N(n));
     b = zeros(N(n), 1);

     for r = 1:N(n)
         if mod(r,2) == 1 
             b(r,1) = 1;
         end
          for c = 1:N(n)
               if r == c
                   A(r,c) = N(n);
               else
                   A(r,c) = exp(-abs(r-c)/N(n));
               end
          end
     end
     
     tic;
        [Q,R] = qrsolve(A);
     toc;
     QR_time = toc;
     QR_times = [QR_times, QR_time];
     
     tic;
        %%% caution : R \ Q'*b
        x = zeros(N(n),1);
        x(N(n),1) = b(N(n))/R(N(n),N(n)); 
        for i = n-1:-1:1
            x(i,1) = (b(i,1)-R(i,i+1:n)*x(i+1:n,1))/R(i,i);
        end    
     toc;
     QR_sol_time = toc;
     QR_sol_times = [QR_sol_times, QR_sol_time];  
end

QR_sol_times = QR_sol_times + QR_times;


 loglog(N,QR_times, 'o')
 hold on
 loglog(N,QR_sol_times, '*')
 loglog(N,QR_tt(N), '-')
 loglog(N,QR_sol_tt(N), '--')
 title('CPU time and Complexity of Solving linear system by QR decomposition')
 xlabel('n')
 ylabel('Complexity (CPU time)')
 legend('QR decomposition - CPU time', 'Solving system (total) - CPU time', 'QR decomposition - complexity', 'Solving system (total) - complexity','Location','northwest')
