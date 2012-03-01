function [mean, var] = mean_var(model, x)

k_tt = covSEiso(model.hyp, x, x);
k_x = covSEiso(model.hyp, model.X(1:model.n,:), x);

mean = k_x'*model.sparse_kernel_inv*model.f;
var = k_tt - k_x'*model.sparse_kernel_inv*k_x;
