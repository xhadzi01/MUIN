clear all;
close all;
clc;


%% load data 
for i = 1:1:5
   cislo(i,:) = reshape(load(strcat(num2str(i-1),'.csv')),1,70);
   cisloS(i,:) = imnoise(cislo(i,:),'salt & pepper', 0.1);
   subplot(3, 5,i);
   imshow(reshape(cislo(i,:),10,7));
   subplot(3,5,i+5);
   imshow(reshape(cisloS(i,:),10,7));
end
% init
Alpha   = 0.7;
Beta    = 0.35;
decr    = 0.98;
N       = 2;
W       = rand(10,10,size(cislo(1,:),2))*0.8+0.1;
MaxIter = 500;
okoli = [-1,-1;-1,0;-1,1;0,-1;0,1;1,-1;1,0;1,1;-2,0;0,-2;2,0;0,2;-2,-2;-1,-2;-2,-1;-2,1;-2,2;-1,2;1,2;2,2;2,1;1,-2;2,-2;2,-1];
% learning
for it = 1:1:MaxIter
%% for every pattern
    for vzor = 1:1:5
        %% for every row and column compute squared diff
        for row = 1:1:10
            for col = 1:1:10
                d(col,row) = sum((cislo(vzor,:)-reshape(W(row,col,:),1,70)).^2);
            end
        end
        %% 
        [x,y] = ind2sub(size(d),find(min(d(:))==d));
        %Uprava vah viteze
        W(x,y,:)=W(x,y,:)+Alpha*(reshape(cislo(vzor,:),1,1,70)-W(x,y,:));
        
        for souradnice = 1:length(okoli)
            ys = okoli(souradnice,1);
            xs = okoli(souradnice,2);
            try
               for n = 1:70
               W(x+ys,y+xs,n)=W(x+ys,y+xs,n)+Beta*(cislo(vzor,n)'-W(x+ys,y+xs,n)); 
               end
            catch
                %Warning('Zaporne okoli, preskakuji.');
            end
        end
        
        Alpha = decr*Alpha;
        Beta  = decr*Beta;
    end
end




%Aktivace
hold on;
for vzor = 1:1:5
     for row = 1:1:10
            for col = 1:1:10
                suma = 0;
                for i = 1:70  %Vypocet vzdalenosti vzoru
                    suma=suma+(cisloS(vzor,i)-W(row,col,i))^2;
                end
                d(col,row) = suma;
            end
     end
        index = find(min(d(:))==d);
        [y,x] = ind2sub(size(d),index);
        subplot(3,5,10+vzor);
        imagesc(d);
        hold on;
        scatter(x,y,50,'filled','r');
end
