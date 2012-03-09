objective_fct = @(x) objective(X);

bounds = [-2,2; -1,3];
d = 2;
init_pt = [1,2];
init_f = objective(init_pt);

hyp = [log(0.5);0];

model = init_model(d, bounds, init_pt, init_f, hyp, 10e-6);

model = sparse_opt(@objective, 30, model);

plot2d(model)


