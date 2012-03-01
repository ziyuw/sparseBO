function model = update_kernel(model, x)

m = model.m;

k_x = covSEiso(model.hyp, model.X(1:m,:), x);
k_tt = covSEiso(model.hyp, x, x);

a_t = model.sparse_kernel_inv*k_x;
delta_t = k_tt + model.noise - a_t'*k_x;

m = m + 1;
model.m = m;
    
sparse_kernel_inv_old = model.sparse_kernel_inv;
model.sparse_kernel_inv = zeros(m,m);
model.sparse_kernel_inv(1:m-1, 1:m-1) = sparse_kernel_inv_old + (a_t*a_t')/delta_t;
model.sparse_kernel_inv(m, 1:m-1) = -a_t'/delta_t;
model.sparse_kernel_inv(1:m-1, m) = -a_t/delta_t;
model.sparse_kernel_inv(m, m) = 1/delta_t;

