function [ mu, sigma, pi ] = em_gaussian(x, k, iteration)
% Expectation Maximization
% Input x is a matrix with its columns data points
% k is the expected size of clusters

    if(nargin < 3) 
        iteration = 300;
    end
    
    [data_size, ds_size] = size(x);
    
    % We get started with mu calcualted from kmean 
    % and identity covariance matrix and iid pi 
    [mu, ul1, ul2] = kmean(x, k, 500);
    sigma = [];
    pi = ones(k,1) / k;
    
    for index = 1 : k
        sigma = cat(3, sigma, eye(data_size));
    end
    
    for ite = 1: iteration
        oldmu = mu;
        oldsigma = sigma;
        oldpi = pi;
        % Expectation
        gamma = zeros([k,ds_size]);
        for n = 1: ds_size
            sum = 0;
            for ik = 1: k
                sum = sum + mvnpdf(x(:,n),mu(:,ik),sigma(:,:,ik));
            end
            
            for ik = 1:k
                gamma(ik,n) = mvnpdf(x(:,n),mu(:,ik),sigma(:,:,ik))/sum;
            end
        end
        
        N = zeros([k,1]);
        for ik = 1 : k
            for n = 1: ds_size
                N(ik) = N(ik) + gamma(ik,n);
            end
        end
        
        % Maximization
        for ik = 1:k
            % Update mu
            mu(:,ik) = zeros([data_size,1]);
            for n = 1: ds_size
                mu(:,ik) = mu(:,ik) + gamma(ik,n)*x(:,n);
            end
            mu(:,ik) = mu(:,ik) / N(ik);
            
            % Update sigma
            sigma(:,:,ik) = zeros(data_size);
            for n = 1: ds_size
                x_mu = x(:,n) - mu(:,ik);
                sigma(:,:,ik) = sigma(:,:,ik) + gamma(ik,n)*x_mu*x_mu';
            end
            sigma(:,:,ik) = sigma(:,:,ik) / N(ik);
            
            % Update pi
            pi(ik) = N(ik) / ds_size;
        end
        
        % Early Stop
        if isequal(oldmu, mu) && isequal(oldsigma, sigma) && isequal(oldpi, pi) 
            return;
        end
    end
end

