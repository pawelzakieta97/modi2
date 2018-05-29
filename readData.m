function data = readData(fileName)
danestat = fopen(fileName,'r');
a = fscanf(danestat,'%f');
data(:,1) = a(1:2:end);
data(:,2) = a(2:2:end);
fclose(danestat);