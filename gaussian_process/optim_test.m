% Estimate t1
beta = 0.6;

func_optim_1 = @(theta) exp_objective(theta,x,t(1,:),beta);
theta_opt = fsolve(func_optim_1,[1 1 1 1],optimoptions(@fsolve,'Algorithm','levenberg-marquardt'));

kernel = @(x_1,x_2) exp_kernel(x_1,x_2, theta_opt);

[mu,sigma] = gaussian_process(x(:,2:67),t(1,2:67),x(:,1),kernel,beta);
mu
t(:,1)