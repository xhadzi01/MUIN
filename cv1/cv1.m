%MUIN 2010/11 cv1

clc;
close all;
clear all;

%% Priklad 1
data = csvread('data1.csv')
vysledek_a = data(1,:)*data(2,:)'
vysledek_b = data(1,:)'*data(2,:)
%% Priklad 2
load('data2.mat');
[r s] = size(data);
suma1 = 0;
for i = 1:r
    for j = 1:s
        suma1 = suma1 + data(i, j);
    end
end
disp('Pomoci foru: ')
suma1

disp('Pomoci sumy: ')
suma2 = sum(sum(data))

disp('Jinak: ')
suma3 = (data*ones(r, 1))'*ones(r, 1)

mat1 = data(5:10, 34:40)
mat2 = data(28:34, [4 9 12 25 38 46])
mat3 = data(17:22, 2)

nasobeni = mat1*mat2*mat3/2000
%% Priklad 3
data = csvread('data3.csv');

sude1 = data(1, 2:2:end);
liche1 = data(1, 1:2:end);

sude2 = data(2, 2:2:end);
liche2 = data(2, 1:2:end);

sude1 = sude1(1:100);
liche1 = liche1(1:100);
sude2 = sude2(1:100);
liche2 = liche2(1:100);

figure(1)
subplot(2,1,1);
hold on;
plot(1:100, sude1);
plot(1:100, sude2, 'g');
title('Suda data');
xlabel('osa x');
ylabel('osa y');

subplot(2,1,2);
hold on;
plot(1:100, liche1);
plot(1:100, liche2, 'r');
title('Licha data');
xlabel('osa x');
ylabel('osa y');

%% Priklad 4
pom = imread('1.bmp');
[r_obr s_obr] = size(pom);                  %zjisteni velikosti vzoru

in = zeros(10, r_obr * s_obr);              %vytvoreni vstupni matice 
for i = 1:10                                %nacteni trenovacich vzoru
    m = imread([num2str(i) '.bmp']);
    in(i,:) = m(:);      
end

figure(1)
colormap(gray);                              %cernobile vykreslovani 
hold on
axis('off');
for i = 1:10                                %vykresleni trenovacich vzoru
    m = reshape(in(i, :), r_obr, s_obr);
    subplot(2,5,i);
    image(m*255);
end


