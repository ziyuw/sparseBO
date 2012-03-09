rand('twister',0); %randn('state',1);
m = 50; n = 128; k = 14;                   % No. of rows (m), columns (n), and nonzeros (k)
[A,Rtmp] = qr(randn(n,m),0);               % Random encoding matrix with orthogonal rows
A  = A';                                   % ... A is m-by-n
p  = randperm(n); p = p(1:k);              % Location of k nonzeros in x
x0 = zeros(n,1); x0(p) = randn(k,1);       % The k-sparse solution
% b  = A*x0;


b  = randn(m,1);

sigma = 0;
opts = spgSetParms('verbosity',0);
x = spg_bpdn(A, b, sigma, opts);

% norm(x-x0)
% tau = 5;
% x = spg_lasso(A, b, tau, opts);
% norm(A*x-b)


tol = 0.01;
count = 0;
for i =1:size(x,1)
    if abs(x(i)) > tol
        count = count+1;
    end
end

count
