function model = sparse_opt(objective_func, num_iter, model)

%  model contains (sparse_kernel, sparse_kernel_inv, dict, m, A, vu, bounds, hyp, n, X, f)

%  bounds is an d*2 vector specifing the bounds

%  dict is an 10000*d array where d is the dimension of the input space 
%  	10000 is the size of preallocation 
%  	m is the number of points in the dictionary 

%  vu is the approximation factor

%  Compute k_{t-1}(x)

opt.maxevals = 500;
opt.maxits = 100;
opt.showits = 0;

for i = 1:num_iter
    fprintf('Iteration: %4i\n', i)
    problem.f = @(x)-1*ei(model, x');
    [ret_minval, final_xatmin, history] = direct(problem, model.bounds, opt);
    f_t = objective_func((final_xatmin)');
    model = update_model(model, f_t, final_xatmin');
    
    if model.display
        disp((final_xatmin)');
        disp(f_t);
    end
end

fprintf('The final value of m: %4i\n', model.m)
