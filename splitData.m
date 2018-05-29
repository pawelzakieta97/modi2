function [ucz,wer] = splitData(data)
ucz = data(1:2:end,:);
wer = data(2:2:end,:);