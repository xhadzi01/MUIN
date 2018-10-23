clc;clear all; close all;
 

%% load data 
for i = 1:1:6
   cislo(i,:) = reshape(load(strcat(num2str(i-1),'.csv')),1,19*19)*2-1;
   cisloS(i,:) = reshape(imnoise(load(strcat(num2str(i-1),'.csv')),'salt & pepper', 0.1),1,19*19)*2-1;
   subplot(3, 6,i);
   imshow(reshape(cislo(i,:),19,19));
   subplot(3,6,i+6);
   imshow(reshape(cisloS(i,:),19,19));
end

%% initialize Hopfield matrix
No = size(cislo(1,:),2);  % No of imputs

%% learning 
W = zeros(No,No);
for i = 1:1:6
    W = W + cislo(i,:)'*cislo(i,:);
end 
W = W - diag(diag(W));

 %% inicialization
 for pic = 1:1:6
     m = cisloS(pic,:);
     ml = zeros(1,No);
     %% activation
    while (1)
       m=m*W;
       m(m<0) = -1;    m(m>=0)= 1;
        if (m == ml)
            break;
        end
        ml = m ; 
    end

    %% graphs
      subplot(3,6,12+pic);
       imshow(reshape(m,19,19));
 end