function [ mu, r, ite ] = kmean(x, k, iteration)
% k-mean clustering
% The input x is a collection of column vectors, 
% k is the number of clusters
% iteration is the maximal number of iteration count

% This function returns the center of each cluster in mu, and cluster
% assignment in r, and used iteration in ite
    if(nargin < 3)
        iteration = 200;
    end

    % We start by choosing the first k element in x 
    [v_size, ds_size] = size(x);
    if k > ds_size 
       err = MException('Not enough data'); 
       throw(err);
    end

    mu = x(:,1:k);
    r = zeros([k,ds_size]);
    % Iteratively minimize mu and r
    for ite = 1 : iteration
        rold = r;
        
        % We first minimize r by choosing the k that minimize || x - mu_k || 
        
        for n = 1 : ds_size
            min_val = Inf;
            k_choice = -1;
            for k_index = 1 : k
                cur_val = norm(x(:,n)-mu(:,k_index));
                if cur_val < min_val
                    min_val = cur_val;
                    k_choice = k_index;
                end
            end
            r(:,n) = zeros([k,1]);
            r(k_choice,n) = 1;
        end
        
        % We then minimize mu_k by assign it the mean of the data in
        % cluster_k
        for k_index = 1 : k
            k_value = zeros([v_size,1]);
            k_size = 0;
            for n = 1 : ds_size
                if r(k_index,n) == 1
                    k_value = k_value + x(:,n);
                    k_size = k_size + 1;
                end
            end
            if k_size == 0 
                mu(:,k_index) = zeros([v_size,1]);
            else
                mu(:,k_index) = k_value / k_size;
            end
        end
        
        if rold == r
            % Assignment doesn't change in this iteration
            % Exit
            return;
        end
    end
    
    return;
end

