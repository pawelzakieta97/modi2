fig = figure('rend','painters','pos',[10 10 1200 600]);
s = 1:15;
semilogy(s,errorsUcz,'b','Marker','o');
hold on;
grid on;

title('B��d aproksymacji w funckji stopnia wielomianu');
legend("dane ucz�ce", "dane weryfikuj�ce");

fileName = ['1\1d-b��dy.svg'];
print('-dsvg','-r600', fileName);
hold off;
%close(fig);