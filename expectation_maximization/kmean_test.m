x = [];

for i = 1:50
    x = [x [rand * 2 + 5; rand * 3 + 4]];
end

for i = 1:70
    x = [x [rand * 3; rand * 5]];
end

[mu, r, ite] = kmean(x,3,50);

figure
hold on
scatter(x(1,:),x(2,:));
scatter(mu(1,1),mu(2,1),64,'r','x');
scatter(mu(1,2),mu(2,2),64,'g','x');
scatter(mu(1,3),mu(2,3),64,'m','x');
hold off