nA = 1;
nB = 1;
stopienU = 1;
stopienY = 1;
ucz = readData('danedynucz49.txt');
wer = readData('danedynwer49.txt');
u = ucz(:,1);
y = ucz(:,2);
M2 = generateNonLinDynMatrix(stopienU,stopienY,nB,nA,u,y);
M1 = generateLinDynMatrix(nB,nA,u,y);

y = y(2:end);

w = M1\y;
yrek1 = modelDynLinR(w,nB,ucz(:,1));
yrek2 = modelDynNlinR(w,1,1,nB,nA,ucz(:,1));
% t = max(nB,nA)+1:2000;
% plot(t,y);
% hold on;
% plot(t,M*w);
% ymodrek = modelDynNlinR(w,stopienU,stopienY,nB,nA,ucz(:,1));
% plot(t,ymodrek(max(nB,nA)+1:end));