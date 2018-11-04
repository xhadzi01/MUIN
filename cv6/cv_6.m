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
Alpha   = 0.9;
Beta    = 0.5;
decr    = 0.98;
N       = 2;
W       = rand(10,10,size(cislo(1,:),2))*0.8+0.1;
MaxIter = 500;
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
            
         for n = 1:70
            try
            [xn,yn] = ind2sub(5*5,n);
            if n == (5*2+3)
            	W(x,y,:)=W(x,y,:)+Alpha*(reshape(cislo(vzor,:),1,1,70)-W(x,y,:));
            else
                W(x+xn-3,y+yn-3,:)=W(x+xn-3,y+yn-3,:)+Beta*(reshape(cislo(vzor,:),1,1,70)-W(x+xn-3,y+yn-3,:));
            end
            catch
                %Warning('Zaporne okoli, preskakuji.');
            end
         end
    end
        Alpha = decr*Alpha;
        Beta  = decr*Beta;
end

%Aktivace
hold on;
for vzor = 1:1:5
    for row = 1:1:10
            for col = 1:1:10
                suma = 0;
                d(col,row) = sum((cisloS(vzor,:)-reshape(W(row,col,:),1,70)).^2);
            end
     end
        [x,y] = ind2sub(size(d),find(min(d(:))==d));
        subplot(3,5,10+vzor);
        imagesc(d);
        hold on;
        scatter(x,y,50,'filled','r');
end
