ucz = readData('danedynucz49.txt');
wer = readData('danedynwer49.txt');
s = size(ucz);
mucz = s(1);
s = size(wer);
mwer = s(1);
%generowanie wykresu danych dynamicznych uczacych
figure('rend','painters','pos',[10 10 1200 600]);
subplot(1,2,1);
plot(1:mucz,ucz(:,1),'b');
hold on;
plot(1:mucz,ucz(:,2),'r');
grid on;
legend("sygna� steruj�cy danych ucz�cych","sygna� wyj�ciowy danych ucz�cych");
subplot(1,2,2);
plot(1:mwer,wer(:,1),'b');
hold on;
plot(1:mwer,wer(:,2),'r');
grid on;
legend("sygna� steruj�cy danych weryfikuj�cych","sygna� wyj�ciowy danych weryfikuj�cych");
fileName = '2\2a.svg';
print('-dsvg','-r600', fileName);
hold off;

ErrorsUcz = zeros(10,1);
ErrorsWer = zeros(10,1);
for i = 1:10
    
    nB = i;
    nA = i;
    yucz = ucz(max(nB,nA)+1:end,2);
    ywer = wer(max(nB,nA)+1:end,2);
    M = generateLinDynMatrix(nB,nA,ucz(:,1),ucz(:,2));
    w = M\yucz;
    
    M2 = generateLinDynMatrix(nB,nA,wer(:,1),wer(:,2));
    yBRekUcz = M*w;
    yBRekWer = M2*w;
    
    yRekUcz = modelDynLinR(w,nB,ucz(:,1));
    ErrorsUcz(i) = norm(yRekUcz(max(nB,nA)+1:end) - yucz);
    yRekWer = modelDynLinR(w,nB,wer(:,1));
    ErrorsWer(i) = norm(yRekWer(max(nB,nA)+1:end) - ywer);
    
    fig = figure('rend','painters','pos',[10 10 1400 600]);
    subplot(1,2,1);
    plot(1:mucz,ucz(:,1),'g');
    hold on;
    plot(1:mucz,ucz(:,2),'b');
    plot(1:mucz,yRekUcz,'r');
    title(["Odpowied� modelu w trybie z rekurencj�" "dla danych ucz�cych rz�du "+num2str(i)]);
    legend("sygna� steruj�cy ucz�cy","sygna� wyj�ciowy ucz�cy","sygna� wyj�ciowy wyznaczonego modelu");
    grid on;
    
    subplot(1,2,2);
    plot(1:mwer,wer(:,1),'g');
    hold on;
    plot(1:mwer,wer(:,2),'b');
    plot(1:mwer,yRekWer,'r');
    title(["Odpowied� modelu w trybie z rekurencj�" "dla danych weryfikuj�cych rz�du "+num2str(i)]);
    legend("sygna� steruj�cy weryfikuj�cy","sygna� wyj�ciowy weryfikuj�cy","sygna� wyj�ciowy wyznaczonego modelu");
    grid on;
    
    fileName = ['2\2b rekurencyjny rzedu ', num2str(i), '.svg'];
    print('-dsvg','-r600', fileName);
    hold off;
    close(fig);
    
    
 
    fig = figure('rend','painters','pos',[10 10 1400 600]);
    subplot(1,2,1);
    plot(1:mucz,ucz(:,1),'g');
    hold on;
    plot(1:mucz,ucz(:,2),'b');
    ybrek = M*w;
    plot(max(nB,nA)+1:mucz,yBRekUcz,'r');
    title(["Odpowied� modelu w trybie bez rekurencji" "dla danych ucz�cych rz�du "+num2str(i)]);
    legend("sygna� steruj�cy ucz�cy","sygna� wyj�ciowy ucz�cy","sygna� wyj�ciowy wyznaczonego modelu");
    grid on;
    
    subplot(1,2,2);
    plot(1:mwer,wer(:,1),'g');
    hold on;
    plot(1:mwer,wer(:,2),'b');
    plot(max(nB,nA)+1:mwer,yBRekWer,'r');
    title(["Odpowied� modelu w trybie bez rekurencji" "dla danych weryfikuj�cych rz�du "+num2str(i)]);
    legend("sygna� steruj�cy weryfikuj�cy","sygna� wyj�ciowy weryfikuj�cy","sygna� wyj�ciowy wyznaczonego modelu");
    grid on;
    
    fileName = ['2\2b bez rekurencji rzedu ', num2str(i), '.svg'];
    print('-dsvg','-r600', fileName);
    hold off;
    close(fig);
    
    save('2\BladDaneUczaceRekurencyjne.mat','ErrorsUcz');
    save('2\BladDaneWeryfikujaceRekurencyjne.mat','ErrorsWer');
    
end