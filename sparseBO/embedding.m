objective_fct = @(x) objective(X);

bounds = [-2,2; -2,2];
d = 2;
init_pt = [1,2];
init_f = objective(init_pt);

hyp = [log(0.5);0];

n = 10; m = 2;

A = randn(n,m);

model = init_model(d, bounds, init_pt, init_f, hyp, 10e-6, A);

model = sparse_opt(@objective, 100, model, A);

plot2d(model, A)

