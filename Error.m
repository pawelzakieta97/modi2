function e = Error(M,w,y)
% s = size(u);
% e = 0;
% for i=1:s(1)
%     e = e+(y(i) - polynomial(w,u(i)))^2;
% end
e = norm(M*w-y);