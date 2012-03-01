function model = update_kernel(model, x)

m = model.m;

k_x = covSEiso(model.hyp, model.dict(1:m,:), x);
k_tt = covSEiso(model.hyp, x, x);

a_t = model.sparse_kernel_inv*k_x;
delta_t = k_tt + model.noise - a_t'*k_x;

%  ann = a_t'*k_x
%  model.sparse_kernel_inv
%  inv(model.sparse_kernel)

%  if delta_t > model.vu
    m = m + 1;
    model.m = m;
    
    %  Recompute sparse_kernel and its inverse
%      sparse_kernel_old = model.sparse_kernel;
%      model.sparse_kernel = zeros(m,m);
%      model.sparse_kernel(1:m-1, 1:m-1) = sparse_kernel_old;
%      model.sparse_kernel(m, 1:m-1) = k_x';
%      model.sparse_kernel(1:m-1, m) = k_x;
%      model.sparse_kernel(m, m) = k_tt + 1; 
    
    sparse_kernel_inv_old = model.sparse_kernel_inv;
    model.sparse_kernel_inv = zeros(m,m);
    model.sparse_kernel_inv(1:m-1, 1:m-1) = sparse_kernel_inv_old + (a_t*a_t')/delta_t;
    model.sparse_kernel_inv(m, 1:m-1) = -a_t'/delta_t;
    model.sparse_kernel_inv(1:m-1, m) = -a_t/delta_t;
    model.sparse_kernel_inv(m, m) = 1/delta_t;

	model.dict(model.m,:) = x;

    a_t = zeros(m, 1); a_t(m, 1) = 1;
    % Enlarge the size of A
    % NOTE: this is highly inefficient
    model.A = [model.A zeros(size(model.A,2), 1)];
%  end
%  
%  mcov = model.sparse_kernel_inv
%  mcov = model.sparse_kernel
%  mcov = model.sparse_kernel*model.sparse_kernel_inv

model.A = cat(1, model.A, a_t');
