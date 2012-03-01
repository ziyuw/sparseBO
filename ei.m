function ei = expected_improvement(model, x, max_val)

[mu, var] = mean_var(model, x);

sigma = sqrt(var);




Z = (mu - model.max_val)/sigma;
ei = (mu - model.max_val)*normcdf(Z, 0, 1) + sigma*normpdf(Z,0,1);
