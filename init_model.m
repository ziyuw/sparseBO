function model = init_model(d, bounds, init_pt, init_f, hyp, vu)

model.hyp = hyp;
model.bounds = bounds;

model.sparse_kernel = covSEiso(model.hyp, init_pt, init_pt)+1;
model.sparse_kernel_inv = 1/covSEiso(model.hyp, init_pt, init_pt);

model.dict = zeros(10000, d);
model.dict(1, :) = init_pt;

model.X = zeros(10000, d);
model.X(1, :) = init_pt;

model.f = init_f;

model.vu = vu;
model.m = 1;
model.n = 1;

model.A = 1;

model.max_val = init_f;