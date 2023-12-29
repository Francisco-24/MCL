clear all
clc
% opts = detectImportOptions('stresses.csv');
% opts.SelectedVariableNames = 2;
% opts.DataRange = '3:end';
% opts.Delimiter = " ";

M = readmatrix('Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');
StressXX = M(:,4);