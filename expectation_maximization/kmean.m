function [ mu, r, ite ] = kmean( x, k, iteration = 200 )
% k-mean clustering
% The input x is a collection of column vectors, 
% k is the number of clusters
% iteration is the maximal number of iteration count

% This function returns the center of each cluster in mu, and cluster
% assignment in r, and used iteration in ite

    % We start by choosing the first k element in x 
    [v_size, ds_size] = size(x);
    if k > ds_size 
       err = MException('Not enough data'); 
       throw(err);
    end

    mu = x(:,1:k);
    r = zeros([n,k]);
    % Iteratively minimize mu and r
    for ite = 1 : iteration
        rold = r;
        
        
        
        if rold == r
            % Assignment doesn't change in this iteration
            % Exit
            return;
        end
    end
    
    return;
end

