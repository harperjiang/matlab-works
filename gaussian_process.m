function [mu, sigma] = gaussian_process(train, target, input, kernel, beta)
    % This function estimate the mean and variance for the given input based on
    % the training data and target value, with error variance beta
    %
    % all data has their column as input vectors
    [input_length, sample_size] = size(train);
    [target_length, sample_size] = size(target);
    
    % Covariance Matrix
    cm = zeros(sample_size);
    for i = 1:sample_size
        for j = i:sample_size
            cm(i,j) = kernel(train(:,i),train(:,j)) + beta;
            cm(j,i) = cm(i,j);
        end
    end
    % Covariance vector
    k = zeros([sample_size,1]);
    for i = 1: sample_size
        k(i) = kernel(train(:,i),input);
    end
    
    c = kernel(input, input);
    
    inv_cm = inv(cm);
    mu = k' * inv_cm * target';
    sigma = c - k'* inv_cm * k;
    
    return;
end