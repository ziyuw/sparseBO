objective_fct = @(x) (1-x(1,1))^2 + 100*(x(1,2)-x(1,1)^2)^2;

%  [X,Y] = meshgrid(-2:0.02:2,-1:0.02:3);
%  Z = (1-X).^2 + 100.*(Y-X.^2).^2;
%  contour(X, Y, Z, 200);

bounds = [-2,2; -1,3];
d = 2;
init_pt = [1,2];
init_f = objective_fct(init_pt);

vu = 10e-5;

hyp = [1;0];

model = init_model(d, bounds, init_pt, init_f, hyp, vu);

sparse_opt(objective_fct, 5, model);