function result = exp_objective(theta, x, t, beta)
    [target_length, sample_size] = size(t);
    
    % Covariance Matrix
    cm = zeros(sample_size);
    for i = 1:sample_size
        for j = i:sample_size
            cm(i,j) = exp_kernel(x(:,i),x(:,j), theta) + beta;
            cm(j,i) = cm(i,j);
        end
    end
    
    % Maximize the log likelihood
    result = 0.5 * log(det(cm)) + 0.5 * t * (cm \ t');
    return;
end

