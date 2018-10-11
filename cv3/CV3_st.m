%%jednovrstva neuronova sit s 5-ti neurony pro dekodovani 5-ti cislic
%%morseovky

clear all
close all
clc

in = csvread('data.csv');

w = rand(5, 6)/10;       %inicializace vah
d = eye(5)*2-1;        %inicializace spravnych vysledku
y = zeros(1,5);
alfa = 0.02;            %ucici konstanta
cykl = 1;                   
maxcykl = 5000;         %max pocet cyklu
Ec = 100;               %pocatecni chyba
Ec_max = 0.5;           %pozadovana chyba

while(cykl < maxcykl) && (Ec > Ec_max)
    Ec=0;
    for n = 1:5
       y = tanh(w * [1 in(n, :)]');
       err = (d(n,:) - y');
       w = w + ([1 in(n,:)]' * alfa *(err .* (1 - y.^2)'))';
       Ec = Ec + 0.5 * err * err';
    end
   
    Ec_it(cykl) = Ec;
    cykl = cykl + 1;
    
end

figure(1)
plot(Ec_it);
title('Chyba site');
xlabel('Iterace'); 
ylabel('Ec');                %vykresleni prubehu chyby


% pro grafy 'bar' a 'ylim'


figure (2)
for i = 1:5
    subplot(1,5,i)
    colormap(gray);         %cernobile vykreslovani
    bar(in(i, :));
    ylim([-1, 1]);
end


figure (3)
for i = 1:5
    y = tanh(w * [1 in(i, :)]');
    subplot(1,5,i)
    colormap(gray);         %cernobile vykreslovani
    bar(y);
    ylim([-1, 1]);
end

