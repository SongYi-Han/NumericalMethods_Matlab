function [phi] = LagranCharPoly(nodes, x_vec)
    % Definition the lagrangian characteristic polynomials apllied to the
    % vector of evaluation points
    %
    % Input:
    %       nodes (NbNodes, float): x coordinates of the interpolation(x-axis)
    %       x_vec (NbEvaluatedPoints, floats): x coordinates of the
    %       evaluation points
    %
    % Returns:
    %        phi (NbEvaluatedPoints x Nodes, float matrix): the matrix
    %        corresponding to all the characteristic polynomials applied to
    %        the evaluated points
    %
    % -------------------------Initialisation-------------------------------
    % Getting the number of characteristic polynomials to retrieve 
    % (the order will be n-1)
    n = length(nodes);
    
    % Getting the number of points to evaluate at 
    n_x = length(x_vec);
    
    % Initialising the polynomials to one (neutral element for the product)
    phi = ones(n_x, n);
    
    %
    % ---------------Generate the characteristic polynomials----------------
    %
    % Loop over the characteristic functions, generate the kth function
    for k=1:n       
        % Looping over the terms that are involved in my char polynomial
        for j =1:n
            % Excluding the kth term and updating the values at the
            % evaluated points
            if j~=k
                phi(:,k) = phi(:,k).*(x_vec'-nodes(j))/(nodes(k)-nodes(j));
            end
        end
    end
end
   
