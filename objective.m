function Y = objective(X)

NR = size(X,1);
Y = zeros(NR, 1);

for i =1:NR
    Y(i,:) = -(0-X(i,1))^2 + -(1-X(i,2))^2;
end

