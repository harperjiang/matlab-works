function [ result ] = exp_kernel( x_1, x_2, theta )
    result = theta(0) * exp(-theta(1) * norm(x_1 - x_2).^2 /2) + theta(2) + theta(3) * x_1' * x_2;
    return;
end

