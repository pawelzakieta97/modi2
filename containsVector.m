function b = containsVector(M,v)
s = size(M);
b = false;
for i=1:s(1)
    if v==M(i,:)
        b = true;
        break;
    end
end