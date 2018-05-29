function w = polynomial(coef,x)
w = coef(1);
s = size(coef);
for i = 2:s(1)
    w = w + coef(i)*x^(i-1);
end