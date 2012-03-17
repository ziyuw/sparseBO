function [mean, var] = mean_var(model, x)

k_tt = model.cov_model(model.hyp, x, x);
k_x = model.cov_model(model.hyp, model.X(1:model.n,:), x);

pre_left = model.Q_T*k_x;
left = model.dense_inverse*pre_left;
right = model.Q_T*model.f;


mean = (model.f'*k_x - left'*right)/model.noise;
var = k_tt - (k_x'*k_x - pre_left'*left)/model.noise;



% var_try = k_tt - k_x'*inv(model.noise*eye(model.n,model.n) + model.A_T'*model.L*model.L'*model.A_T)*k_x;
% var = k_tt - k_x'*inv(model.noise*eye(model.n,model.n)+model.A_T'*model.sparse_kernel*model.A_T)*k_x;

% var-var_try

%  true_var = k_tt - k_x'*model.sparse_kernel_full_inv*k_x;


% var = true_var;

%  if var < 0
%      
%  %     norm(model.sparse_kernel_inv)
%  %     norm(inv(model.noise*eye(model.n,model.n)+model.A_T'*model.L*model.L'*model.A_T))
%      
%      nn = norm(inv(model.noise*eye(model.n,model.n)+model.A_T'*model.L*model.L'*model.A_T)-model.sparse_kernel_full_inv);
%  
%      c = cond(model.noise*eye(model.n,model.n)+model.A_T'*model.L*model.L'*model.A_T);
%      fprintf('Variance below zero!!!! %f with condition: %f  %f\n', var, c, nn)
%  end

if var < 0
	fprintf('Variance below zero!!!! %f \n', var);
%  	whatthehell;
end

var = max(0, var);

%  if var < 0 && abs(var) < model.noise
%      var = model.vu;
%  end
%  

