function model = init_model(d, bounds, init_pt, init_f, hyp, vu)

model.noise = 10e-6;

model.hyp = hyp;
model.bounds = bounds;

model.sparse_kernel_inv = 1/(covSEiso(model.hyp, init_pt, init_pt) + model.noise);
model.X = zeros(10000, d);
model.X(1, :) = init_pt;
model.f = init_f;

model.vu = vu;
model.m = 1;
model.n = 1;

model.max_val = init_f;
