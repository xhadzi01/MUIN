clc; clear all; close all;
dataVect = load('data.csv');
teacherVect = eye(5)*2-1;
A = OneLayerNetwork(dataVect,teacherVect);
A = computeUntil(A);

%% test povodnych hodnot
testMe(A,dataVect,1)

%% test zasumenych hodnot
randomVals = rand(5, 5).*0.6;   %
randomVals = randomVals - mean2(randomVals);
dataVect = dataVect + randomVals;
testMe(A,dataVect,1)
