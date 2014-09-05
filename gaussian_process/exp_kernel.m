function [ result ] = exp_kernel( x_1, x_2, theta )
    result = theta(1) * exp(-theta(2) * norm(x_1 - x_2).^2 /2) + theta(3) + theta(4) * x_1' * x_2;
    return;
end

