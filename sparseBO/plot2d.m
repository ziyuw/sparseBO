function plot2d(model, A)



X1 = model.bounds(1,1):0.1:model.bounds(1,2);
X2 = model.bounds(2,1):0.1:model.bounds(2,2);
[X,Y] = meshgrid(X1,X2);
Z = objective((model.A*[X(:) Y(:)]')');
Z = reshape(Z,length(X1),length(X2));
contour(X, Y, Z, 20);

hold on;
scatter(model.X(1:model.n, 1), model.X(1:model.n, 2), 40, 'filled');
hold off;