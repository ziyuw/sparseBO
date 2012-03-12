function model = init_sparse_model(d, bounds, init_pt, init_f, hyp, noise, vu)

% noise specifies \sigma^2
model.noise = noise;

% Specifies the covariance model
model.cov_model = @covSEiso;

% Specifies the hyper-parameters of the covariance
model.hyp = hyp;

% Specifies the approximation parameter
model.vu = vu;

model.bounds = bounds;

model.X = zeros(10000, d);
model.X(1, :) = init_pt;

model.f = init_f;

model.m = 1; % The number of points in the kernel
model.n = 1; % The number of total observations
model.indices = 1;

model.max_val = init_f; % This is used by EI
model.display = 1;


model.L = chol(model.cov_model(model.hyp, init_pt, init_pt));
model.A_T = 1;
model.Q_T = model.A_T'*model.L;

% This is used for computation
model.dense_inverse = inv(model.noise + model.Q_T*model.Q_T');

% The inverse of the reduced kernel
model.sparse_kernel_inv = 1/(model.cov_model(model.hyp, init_pt, init_pt));


model.sparse_kernel = model.cov_model(model.hyp, init_pt, init_pt);



model.sparse_kernel_full_inv = 1/(model.cov_model(model.hyp, init_pt, init_pt) + model.noise);