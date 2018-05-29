function M = generateLinDynMatrix(nB,nA,u,y)
n = max(nB,nA);
s = size(y);
m = s(1);
M = zeros(m-n,nB+nA);
u=u';
y=y';
r = [u(n:-1:n-nB+1) y(n:-1:n-nA+1)];
M(1,1:end)=r;
for i = 2:m-n
    M(i,2:end) = M(i-1,1:end-1);
    M(i,1) = u(n+i-1);
    M(i,nB+1) = y(n+i-1);
end
    