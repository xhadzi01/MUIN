clc; clear all; close all;

%% nacteme data - jednotlive ciselka

figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:1:10
    dataNums{i} = im2double(imread(strcat(num2str(i),'.bmp')));
    subplot(2,10,i);   
    imshow(dataNums{i});
    dataNumsNoise{i} = imnoise((dataNums{i}),'salt & pepper', 0.05);
    subplot(2,10,i+10);   
    imshow(dataNumsNoise{i});
end

%% vytvorenie vektoru priznakov
for i = 1:1:10
    shapedNums{i} = reshape(dataNums{i},size(dataNums{i},1)*size(dataNums{i},2),1);
    shapedNumsNoise{i} = reshape(dataNumsNoise{i},size(dataNums{i},1)*size(dataNums{i},2),1);
end

%% inicializacia 
% pocet vrstv
n_vstupna_vrstva = size(shapedNums{i},1)*size(shapedNums{i},2);
n_skryta_vrstva1 = 30;
n_skryta_vrstva2 = 30;
n_vystupni_vrstva = 10;
% vlastnosti vrstiev    -- weights
weightDelim = 10;
w{1} = rand(10,size(shapedNums{i},1)+1)/weightDelim;
w{2} = rand(n_vstupna_vrstva,n_skryta_vrstva1+1)/weightDelim;
w{3} = rand(n_skryta_vrstva1,n_skryta_vrstva2+1)/weightDelim;
w{4} = rand(n_vystupni_vrstva,n_skryta_vrstva2+1)/weightDelim;
%                       -- vector Y
Y{1} = zeros(n_vstupna_vrstva,1);
Y{2} = zeros(n_skryta_vrstva1,1);
Y{3} = zeros(n_skryta_vrstva2,1);
Y{4} = zeros(n_vystupni_vrstva,1);
%                       -- vector D 

Ec_final = 0.05;
logErr = [];
maxSteps = 1000;
step = 1; 
alpha =  0.005; 
Y = [];
D = [];




%% prepocty
while((step<maxSteps)|(logErr(end)<Ec_final))
    obj.tmpEc = 0; 
    for n = 1:5
         Y = tanh(w * [1 in(n, :)]');
         tmpErr = D(n,:) - Y';
         w = w + alpha *((1 - Y.^2) .* tmpErr')*[1 in(n,:)];

         tmpEc =  tmpEc + 0.5 * tmpErr * tmpErr';
    end
    logErr = [logErr tmpEc];
    step = step+1;    

        
end