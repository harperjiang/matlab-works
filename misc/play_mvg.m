MU = [1 2;-3 -5];
SIGMA = cat(3,[2 0;0 .5],[1 -2;-2 5]);
p = ones(1,2)/2;
obj = gmdistribution(MU,SIGMA,p);

ezcontour(@(x,y)pdf(obj,[x y]),[-10 10],[-10 10])
hold on

rng(1); % For reproducibility
Y = random(obj,1000);

scatter(Y(:,1),Y(:,2),10,'.');