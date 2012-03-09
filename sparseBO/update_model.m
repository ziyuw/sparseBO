function model = update_model(model, f_t, final_xatmin)

model.n = model.n + 1;
model.X(model.n,:) = final_xatmin;
model.f = [model.f; f_t];


if f_t > model.max_val
	model.max_val = f_t;
end

model = update_kernel(model, final_xatmin);

