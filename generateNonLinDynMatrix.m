function M = generateNonLinDynMatrix(stopienU,stopienY,nB,nA,u,y)
n = max(nB,nA);
s = size(u);
m = s(1);
M = zeros(m-n,nB*stopienU+nA*stopienY);
for i=1:m-n
    k = i+n;
    rowU = zeros(1,nB*stopienU);
    rowY = zeros(1,nA*stopienY);
    for probka=1:nB
        for power = 1:stopienU
            rowU((probka-1)*stopienU + power) = (u(k-probka))^power;
        end
    end
    for probka=1:nA
        for power = 1:stopienY
            rowY((probka-1)*stopienY + power) = (y(k-probka))^power;
        end
    end
    M(i,:) = [rowU rowY];
end