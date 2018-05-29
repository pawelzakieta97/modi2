ucz = readData('danedynucz49.txt');
wer = readData('danedynwer49.txt');
nA = 3;
nB = 1;
stopienU = 4;
stopienY = 1;

%modele dla takich wartosci rzedu/stopnia wielomianu beda na wykresach
plots = [[6,4];[6,2];[6,8];[10,4];[2,4];[11,8]];
if 1>0
    ErrorsUcz = zeros(10);
    ErrorsUczRek = zeros(10);
    ErrorsWer = zeros(10);
    ErrorsWerRek = zeros(10);
    for rzad = 1:15
        for stopien = 1:10
            nA = rzad;
            nB = rzad;
            stopienU = stopien;
            stopienY = stopien;
            s = size(ucz);
            mucz = s(1);
            s = size(wer);
            mwer = s(1);
            
            M1 = generateNonLinDynMatrix(stopienU,stopienY,nB,nA,ucz(:,1),ucz(:,2));
            M2 = generateNonLinDynMatrix(stopienU,stopienY,nB,nA,wer(:,1),wer(:,2));
            
            yucz = ucz(max(nB,nA)+1:end,2);
            ywer = wer(max(nB,nA)+1:end,2);
            w = M1\yucz;
            t = max(nB,nA)+1:2000;

            yModUczRek = modelDynNlinR(w,stopienU,stopienY,nB,nA,ucz(:,1));
            yModWerRek = modelDynNlinR(w,stopienU,stopienY,nB,nA,wer(:,1));

            ErrorsUcz(rzad, stopien) = norm(yucz - M1*w);
            ErrorsUczRek(rzad,stopien) = norm(yucz - yModUczRek(max(nB,nA)+1:end));
            
            ErrorsWer(rzad, stopien) = norm(ywer - M2*w);
            ErrorsWerRek(rzad, stopien) = norm(ywer - yModWerRek(max(nB,nA)+1:end));
            
            if containsVector(plots,[rzad,stopien])
                fig = figure('rend','painters','pos',[10 10 1400 600]);
                subplot(1,2,1);
                plot(1:mucz,ucz(:,1),'g');
                hold on;
                plot(1:mucz,ucz(:,2),'b');
                plot(1:mucz,yModUczRek,'r');
                title(["OdpowiedŸ modelu w trybie z rekurencj¹" "dla danych ucz¹cych rzêdu "+num2str(rzad) "i stopniem wielomianiów"+num2str(stopien)]);
                legend("sygna³ steruj¹cy ucz¹cy","sygna³ wyjœciowy ucz¹cy","sygna³ wyjœciowy wyznaczonego modelu");
                grid on;

                subplot(1,2,2);
                plot(1:mwer,wer(:,1),'g');
                hold on;
                plot(1:mwer,wer(:,2),'b');
                plot(1:mwer,yModWerRek,'r');
                title(["OdpowiedŸ modelu w trybie z rekurencj¹" "dla danych weryfikuj¹cych rzêdu "+num2str(rzad) "i stopniem wielomianiów"+num2str(stopien)]);
                legend("sygna³ steruj¹cy weryfikuj¹cy","sygna³ wyjœciowy weryfikuj¹cy","sygna³ wyjœciowy wyznaczonego modelu");
                grid on;

                fileName = ['2d\2b rekurencyjny rzedu ', num2str(rzad),' i stopnia',num2str(stopien), '.svg'];
                print('-dsvg','-r600', fileName);
                hold off;
                close(fig);



                fig = figure('rend','painters','pos',[10 10 1400 600]);
                subplot(1,2,1);
                plot(1:mucz,ucz(:,1),'g');
                hold on;
                plot(1:mucz,ucz(:,2),'b');
                plot(max(nB,nA)+1:mucz,M1*w,'r');
                title(["OdpowiedŸ modelu w trybie bez rekurencji" "dla danych ucz¹cych rzêdu "+num2str(rzad) "i stopniem wielomianiów"+num2str(stopien)]);
                legend("sygna³ steruj¹cy ucz¹cy","sygna³ wyjœciowy ucz¹cy","sygna³ wyjœciowy wyznaczonego modelu");
                grid on;

                subplot(1,2,2);
                plot(1:mwer,wer(:,1),'g');
                hold on;
                plot(1:mwer,wer(:,2),'b');
                plot(max(nB,nA)+1:mwer,M2*w,'r');
                title(["OdpowiedŸ modelu w trybie bez rekurencji" "dla danych weryfikuj¹cych rzêdu "+num2str(rzad) "i stopniem wielomianiów"+num2str(stopien)]);
                legend("sygna³ steruj¹cy weryfikuj¹cy","sygna³ wyjœciowy weryfikuj¹cy","sygna³ wyjœciowy wyznaczonego modelu");
                grid on;

                fileName = ['2d\2b bez rekurencji rzedu ', num2str(rzad),' i stopnia',num2str(stopien), '.svg'];
                print('-dsvg','-r600', fileName);
                hold off;
                close(fig);
                
            end
        end
    end
end
surf([1:10],[1:15],ErrorsWerRek);
hold on;
ylabel("rz¹d");
xlabel("stopieñ");
zlabel("b³¹d");
save('2d\BladDaneUczace.mat','ErrorsUcz');
save('2d\BladDaneUczaceRekurencyjne.mat','ErrorsUczRek');
save('2d\BladDaneWeryfikujace.mat','ErrorsWer');
save('2d\BladDaneWeryfikujaceRekurencyjne.mat','ErrorsWerRek');