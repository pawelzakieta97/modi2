function y = modelDynNlinR(w,stopienU,stopienY,nB,nA,u)
n = max(nB,nA);
s = size(u);
m = s(1);
y = zeros(m,1);
for i=n+1:m
    k = i;
    rowU = zeros(1, nB*stopienU);
    rowY = zeros(1, nA*stopienY);
    for probka=1:nB
        for power = 1:stopienU
            rowU(1,(probka-1)*stopienU + power) = (u(k-probka))^power;
        end
    end
    for probka=1:nA
        for power = 1:stopienY
            rowY(1,(probka-1)*stopienY + power) = (y(k-probka))^power;
        end
    end
    y(i) = [rowU rowY]*w;
end