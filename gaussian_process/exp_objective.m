function result = exp_objective( theta_param, x, t, beta, theta ) 
    [input_length, sample_size] = size(x);
    [target_length, sample_size] = size(t);
    
    theta = theta_param;
    
    % Covariance Matrix
    cm = zeros(sample_size);
    for i = 1:sample_size
        for j = i:sample_size
            cm(i,j) = exp_kernel(x(:,i),x(:,j), theta) + beta;
            cm(j,i) = cm(i,j);
        end
    end
    
    result = -0.5 * log(det(cm)) - 0.5 * t * inv(cm) * t';
    
    return;
end

