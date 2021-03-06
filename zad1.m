daneStat = readData('danestat49.txt');
scatter(daneStat(:,1),daneStat(:,2));
[ucz, wer] = splitData(daneStat);

%generowanie wykresu wszystkich danych statycznych
figure('rend','painters','pos',[10 10 800 500]);
hold on;
title('Dane statyczne');
scatter(daneStat(:,1),daneStat(:,2),'b');
grid on;
fileName = '1\1a.svg';
print('-dsvg','-r600', fileName);

%generowanie wykresow dla 2 zbiorow danych
figure('rend','painters','pos',[10 10 1000 400]);
subplot(1,2,1);
scatter(ucz(:,1),ucz(:,2),'b');
grid on;
legend("dane ucz�ce");
subplot(1,2,2);
scatter(wer(:,1),wer(:,2),'r');
grid on;
legend("dane weryfikuj�ce");
fileName = '1\1b.svg';
print('-dsvg','-r600', fileName);


%dopasowanie prostej na tle 2 zbiorow danych
M = generatePolynomialMatrix(1,ucz(:,1));
w = M\(ucz(:,2));
figure('rend','painters','pos',[10 10 1200 600]);
subplot(1,2,1);
scatter(ucz(:,1),ucz(:,2),'b');
hold on;
title('aproksymacja danych uczacych funckj� liniow�');
fplot(@(x) polynomial(w,x),[-1 1],'g');
grid on;
legend("dane ucz�ce", "dopasowany wielomian");
subplot(1,2,2);
scatter(wer(:,1),wer(:,2),'r');
hold on;
title('aproksymacja danych weryfikuj�cych funckj� liniow�');
fplot(@(x) polynomial(w,x),[-1 1],'g');
grid on;
legend("dane weryfikuj�ce","dopasowany wielomian");
fileName = '1\1c.svg';
print('-dsvg','-r600', fileName);
hold off;

%wyznaczanie wielomianow wyzszych stopni
errorsUcz = zeros(15,1);
errorsWer = zeros(15,1);
for i =1:15
    M = zeros(1);
    w = [];
    M = generatePolynomialMatrix(i,ucz(:,1));
    w = M\ucz(:,2);
    errorsUcz(i) = norm(M*w-ucz(:,2));
    M = generatePolynomialMatrix(i,wer(:,1));
    errorsWer(i) = norm(M*w-wer(:,2));
    
    fig = figure('rend','painters','pos',[10 10 1200 600]);
    subplot(1,2,1);
    
    scatter(ucz(:,1),ucz(:,2),'b');
    title(['Aproksymacja wielomianem ' num2str(i) '. stopnia' newline 'Dane ucz�ce, b��d = ' num2str(errorsUcz(i))]);
    hold on;
    fplot(@(x) polynomial(w,x),[-1 1],'g');
    grid on;
    legend("dane ucz�ce", "dopasowany wielomian");
    xlabel('x');
    ylabel('y(x)');
    subplot(1,2,2);
    scatter(wer(:,1),wer(:,2),'r');
    title(['Aproksymacja wielomianem ' num2str(i) '. stopnia' newline 'Dane weryfikuj�ce, b��d = ' num2str(errorsWer(i))]);
    hold on;
    fplot(@(x) polynomial(w,x),[-1 1],'g');
    grid on;
    legend("dane weryfikuj�ce","dopasowany wielomian");
    fileName = ['1\1d-stopien ' num2str(i) '.svg'];
    print('-dsvg','-r600', fileName);
    hold off;
    close(fig);
end
fig = figure('rend','painters','pos',[10 10 1200 600]);
s=3:15;
semilogy(s',errorsUcz(3:15),'b','Marker','o');
hold on;
grid on;
xlabel('stopie� wielomianu');
ylabel('norma residuum');
plot(s',errorsWer(3:15),'r','Marker','o');
title('B��d aproksymacji w funckji stopnia wielomianu');
legend("dane ucz�ce", "dane weryfikuj�ce");

fileName = ['1\1d-b��dy.svg'];
print('-dsvg','-r600', fileName);
hold off;
close(fig);
