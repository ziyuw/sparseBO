function model = init_model(d, bounds, init_pt, init_f, hyp, noise, random_mat)


model.A = random_mat;

model.noise = noise;
model.cov_model = @covSEiso;

model.hyp = hyp;
model.bounds = bounds;

model.sparse_kernel_inv = 1/(model.cov_model(model.hyp, init_pt, init_pt) + model.noise);
model.X = zeros(10000, d);
model.X(1, :) = init_pt;

model.f = init_f;

model.m = 1;
model.n = 1;

model.max_val = init_f;
model.display = 1;

