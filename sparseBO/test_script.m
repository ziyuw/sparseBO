objective_fct = @(x) objective(X);

bounds = [-2,2; -1,3];
d = 2;
init_pt = [1,2];
init_f = objective(init_pt);

hyp = [log(0.5);0];

var = 0.0001;

model = init_sparse_model(d, bounds, init_pt, init_f, hyp, var, 10e-9);
tic
model = sparse_opt(@objective, 10000, model);
toc
plot2d(model)


