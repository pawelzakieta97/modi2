daneStat = readData('danestat49.txt');
scatter(daneStat(:,1),daneStat(:,2));
[ucz, wer] = splitData(daneStat);

%generowanie wykresu wszystkich danych statycznych
figure('rend','painters','pos',[10 10 600 600]);
hold on;
scatter(daneStat(:,1),daneStat(:,2),'b');
grid on;
legend("dane statyczne");
fileName = '1\1a.svg';
print('-dsvg','-r600', fileName);

%generowanie wykresow dla 2 zbiorow danych
figure('rend','painters','pos',[10 10 1200 600]);
subplot(1,2,1);
scatter(ucz(:,1),ucz(:,2),'b');
grid on;
legend("dane ucz¹ce");
subplot(1,2,2);
scatter(wer(:,1),wer(:,2),'r');
grid on;
legend("dane weryfikuj¹ce");
fileName = '1\1b.svg';
print('-dsvg','-r600', fileName);


%dopasowanie prostej na tle 2 zbiorow danych
M = generatePolynomialMatrix(1,ucz(:,1));
w = M\(ucz(:,2));
figure('rend','painters','pos',[10 10 1200 600]);
subplot(1,2,1);
scatter(ucz(:,1),ucz(:,2),'b');
hold on;
fplot(@(x) polynomial(w,x),[-1 1],'g');
grid on;
legend("dane ucz¹ce", "dopasowany wielomian");
subplot(1,2,2);
scatter(wer(:,1),wer(:,2),'r');
hold on;
fplot(@(x) polynomial(w,x),[-1 1],'g');
grid on;
legend("dane weryfikuj¹ce","dopasowany wielomian");
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
    
    figure('rend','painters','pos',[10 10 1200 600]);
    subplot(1,2,1);
    scatter(ucz(:,1),ucz(:,2),'b');
    hold on;
    fplot(@(x) polynomial(w,x),[-1 1],'g');
    grid on;
    legend("dane ucz¹ce", "dopasowany wielomian");
    subplot(1,2,2);
    scatter(wer(:,1),wer(:,2),'r');
    hold on;
    fplot(@(x) polynomial(w,x),[-1 1],'g');
    grid on;
    legend("dane weryfikuj¹ce","dopasowany wielomian");
    fileName = ['1\1d-stopien ' num2str(i) '.svg'];
    print('-dsvg','-r600', fileName);
    hold off;
    
    
end
