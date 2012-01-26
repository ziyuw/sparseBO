function sparse_opt(objective_func, num_iter, model)

%  model contains (sparse_kernel, sparse_kernel_inv, dict, m, A, vu, bounds, hyp, n, X, f)

%  bounds is an d*2 vector specifing the bounds

%  dict is an 10000*d array where d is the dimension of the input space 
%  	10000 is the size of preallocation 
%  	m is the number of points in the dictionary 

%  vu is the approximation factor

%  Compute k_{t-1}(x)

opt.maxevals = 500;
opt.maxits = 30;
opt.showits = 0;

for i = 1:num_iter
    problem.f = @(x)-ei(model, x');
    [ret_minval, final_xatmin, history] = Direct(problem, model.bounds);

    fprintf('The final value of');
    disp(final_xatmin');

    f_t = objective_func(final_xatmin');
    model = update_model(model, f_t, final_xatmin');

%      problem.f = @(x)temp(1, x);
%      bounds = [-100,100]
%      [ret_minval, final_xatmin, history] = Direct(problem, bounds, opt);
%  
%      final_xatmin
end

fprintf('The final value of m: %4i\n', model.m)