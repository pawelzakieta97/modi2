function y = modelDynLinR(w,nB,u)
s = size(w);
nA = s(1)-nB;s
n = max(nA,nB);
s = size(u);
m = s(1);
y = zeros(1, m);
u=u';
for i=n+1:m
    v = [u(i-1:-1:i-nB) y(i-1:-1:i-nA)];
    y(i)=v*w;
end
y = y';