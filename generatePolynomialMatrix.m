function M = generatePolynomialMatrix(n,u)
M = zeros(length(u),n);
for row = 1:length(u)
    for col = 0:n
        M(row, col+1) = u(row)^col;
    end
end