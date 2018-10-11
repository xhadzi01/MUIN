clc; clear all; close all;
dataVect = load('data.csv');
teacherVect = eye(5)*2-1;
A = OneLayerNetwork(dataVect,teacherVect);
A = computeUntil(A);


