function [coeff] = naturalspline(x_nodes, y_nodes)
    % x_nodes = x valuses for every new interval
    % y_nodes = y valuese for every new interval 
    % coeff = n-1 x 4 matix, [d0 c0 b0 a0; d1 c1 b1 a1; ... ; ]
    
    % vector length
    n = length(x_nodes);
    
    % vector h (intervals vector): 
    h = zeros(n-1,1); 
    for j = 1:n-1
      h(j) = x_nodes(j+1) - x_nodes(j); 
    end
    
    % Coefficient tridiagonal matrix: 
    D_tri = zeros(n);
    
    % Natural Spline boundary conditions: 
    D_tri(1,1)= 1; 
    D_tri(n,n) = 1;
    for i = 2:n-1 
      D_tri(i,i-1) = h(i-1); 
      D_tri(i,i) = 2*(h(i-1)+h(i)); 
      D_tri(i,i+1) = h(i); 
    end
    
    % Vector psi: 
    psi = zeros(n,1);

    for i = 2:n-1 
      psi(i) = (3/h(i))*(y_nodes(i+1)-y_nodes(i)) - (3/h(i-1))*(y_nodes(i)-y_nodes(i-1));     
    end
    
    % Coefficient vector ccs: 
    ccs = D_tri\psi;
    
    % Coefficient vector bbs: 
    bbs = zeros(n-1,1); 
    for i = 1:n-1 
      bbs(i) = (1/h(i))*(y_nodes(i+1)-y_nodes(i)) - (1/3*h(i))*(2*ccs(i)+ccs(i+1)); 
    end
    
    % Coefficient vector dds: 
    dds = zeros(n-1,1); 
    for i = 1:n-1 
      dds(i) = (1/(3*h(i))) * (ccs(i+1)-ccs(i)); 
    end
    
    % Making a matrix coeff with all polynomials 
    coeff = zeros(n-1,4); 
    for i = 1:n-1 
      coeff(i,1) = dds(i); 
      coeff(i,2) = ccs(i); 
      coeff(i,3) = bbs(i); 
      coeff(i,4) = y_nodes(i); 
    end
end
