function model = update_kernel(model, x)

m = model.m;

k_x = model.cov_model(model.hyp, model.X(1:m,:), x);
k_tt = model.cov_model(model.hyp, x, x);

% a_t = model.L'\(model.L\k_x);



a_t = model.sparse_kernel_inv*k_x;
delta_t = k_tt - a_t'*k_x;

n = model.n;

k_x_1 = model.cov_model(model.hyp, model.X(1:n-1,:), x);
a_t_1 = model.sparse_kernel_full_inv*k_x_1;
delta_t_1 = k_tt  + model.noise - a_t_1'*k_x_1;


sparse_kernel_inv_full_old = model.sparse_kernel_full_inv;
model.sparse_kernel_full_inv = zeros(n,n);
model.sparse_kernel_full_inv(1:n-1, 1:n-1) = sparse_kernel_inv_full_old + (a_t_1*a_t_1')/delta_t_1;
model.sparse_kernel_full_inv(n, 1:n-1) = -a_t_1'/delta_t_1;
model.sparse_kernel_full_inv(1:n-1, n) = -a_t_1/delta_t_1;
model.sparse_kernel_full_inv(n, n) = 1/delta_t_1;


delta_t

if delta_t > model.vu
    m = m + 1;
    model.m = m;

    % Rank 2 update on the sparse_kernel_inverse (This is not needed given the cholesky representation)
    sparse_kernel_inv_old = model.sparse_kernel_inv;
    model.sparse_kernel_inv = zeros(m,m);
    model.sparse_kernel_inv(1:m-1, 1:m-1) = sparse_kernel_inv_old + (a_t*a_t')/delta_t;
    model.sparse_kernel_inv(m, 1:m-1) = -a_t'/delta_t;
    model.sparse_kernel_inv(1:m-1, m) = -a_t/delta_t;
    model.sparse_kernel_inv(m, m) = 1/delta_t;

    % Rank 2 update on the sparse_kernel_inverse (This is not needed given the cholesky representation)
    sparse_kernel_old = model.sparse_kernel;
    model.sparse_kernel = zeros(m,m);
    model.sparse_kernel(1:m-1, 1:m-1) = sparse_kernel_old;
    model.sparse_kernel(m, 1:m-1) = k_x';
    model.sparse_kernel(1:m-1, m) = k_x;
    model.sparse_kernel(m, m) = k_tt;

    % Update cholesky L
    z_t = model.L\k_x;
    d_t = chol(max(k_tt - z_t'*z_t, 0));
    model.L = [[model.L, zeros(m-1, 1)];[z_t', d_t]];
    
    
    
    
    
    % Update A_T
    model.A_T = [[model.A_T, zeros(model.m-1, 1)];zeros(1, model.n)];
    model.A_T(model.m,model.n) = 1;
    
    % Update Q
    model.Q_T = [[model.Q_T; zeros(1, model.n-1)], [z_t; d_t]];

    % Update dense Inverse
    model.dense_inverse = [[model.dense_inverse, zeros(m-1,1)]; zeros(1, m)];
    model.dense_inverse(m,m) = 1/model.noise;
    nr = [z_t; d_t];
    a = model.dense_inverse*nr;
    model.dense_inverse = model.dense_inverse - a*a'/(1+nr'*a);
    
else
    fprintf('not not not!\n')
    % Update A_T
    model.A_T = [model.A_T, a_t];
    
    % Update Q
    nr = model.L'*a_t;
    model.Q_T = [model.Q_T, nr];
    
    % Update dense Inverse
    a = model.dense_inverse*nr;
    model.dense_inverse = model.dense_inverse - a*a'/(1+nr'*a);
end

a_t'
nn = norm(inv(model.noise*eye(model.n,model.n)+model.A_T'*model.L*model.L'*model.A_T)-model.sparse_kernel_full_inv)

% nn = norm(model.sparse_kernel - model.L*model.L')

% norm(model.sparse_kernel_inv)
% norm(inv(model.noise*eye(model.n,model.n)+model.A_T'*model.L*model.L'*model.A_T))