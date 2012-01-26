function [mean, var] = mean_var(model, x)

%  model.n
%  size(model.A)

k_tt = covSEiso(model.hyp, x, x);
k_x = covSEiso(model.hyp, model.X(1:model.n,:), x);
Ak_x = model.A'*k_x;


kk = model.A'*model.f;

mean = Ak_x'*model.sparse_kernel_inv*kk;
var = k_tt - Ak_x'*model.sparse_kernel_inv*Ak_x;
%  
%  Ak_x'*model.sparse_kernel_inv*Ak_x
%  k_x
%  model.A
