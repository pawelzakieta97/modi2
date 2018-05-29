function M = generatePolynomialMatrix(n,u)
s = size(u);
M = zeros(s(1),n);
for row = 1:size(u)
    for col = 0:n
        M(row, col+1) = u(row)^col;
    end
end