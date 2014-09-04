real_mu = [1 2;-3 -5; 6 -4];
real_sigma = cat(3,[2 0;0 .5],[1 -2;-2 5],[1 0; 0 1]);
p = ones(1,3)/3;
obj = gmdistribution(real_mu,real_sigma,p);

hold on

rng(1); % For reproducibility
Y = random(obj,1000);

scatter(Y(:,1),Y(:,2),10,'.');

[mu, sigma, pi] = em_gaussian(Y',3,100);

mu = mu';
pi = pi';
estobj = gmdistribution(mu,sigma,pi);
ezcontour(@(x,y)pdf(estobj,[x y]),[-10 10],[-10 10])