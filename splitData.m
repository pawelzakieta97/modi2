function [ucz,wer] = splitData(data)
sorted = sortrows(data,2);
ucz = sorted(1:2:end,:);
wer = sorted(2:2:end,:);