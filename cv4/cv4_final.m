clear all;
close all;
clc;

for i=1:10
%     tmp = imread([num2str(i) '.bmp']);
%     input(i,:) = tmp(:);
    input(i,:) = reshape(imread([num2str(i) '.bmp']),1,18*18);
     
end
[k,l] = size(input);                  
n   = 30;                               % pouzitelne kombinacie n = 30; u = 0.005
delit = 100;                            %                       n = 12; u = 0.03
w1  = rand(n,l+1)/delit;               
w2  = rand(n,n+1)/delit;               
w3  = rand(10,n+1)/delit;                  
u   = 0.005; 
D   = eye(10)*2-1; 
jedna = ones(10,1);
w3l = w3; w2l = w2; w1l = w1;
M = 0.1; 
logErr      = 0;
for iteration = 1:3000
    Es_c = 0; 
    for vzor = 1:1:size(input,1)
        y1 = tanh(w1*[input(vzor,:) 1]');
        y2 = tanh(w2*[y1; 1]);
        y3 = tanh(w3*[y2; 1]);
        Es_c = Es_c + 0.5*sum((D(vzor,:) - y3').^2);
        delta = w3(:,1:end-1)'*(D(vzor,:)-y3')';
        w3 = w3 + u*(ones(10,1)-y3.^2)  .*(D(vzor,:)'-y3)   *[y2; 1]'             + M*(w3-w3l);
        w2 = w2 + u*(ones(n,1)-y2.^2)   .*(delta)           *[y1; 1]'             + M*(w2-w2l);
        w1 = w1 + u*(ones(n,1)-y1.^2)   .*(delta)           *[input(vzor,:) 1]    + M*(w1-w1l);
        w3l = w3;   w2l = w2;   w1l = w1;
    end
    logErr(iteration) = Es_c;
    
end
plot(logErr);
disp(strcat('chyba Es na konci ucenia je :',num2str(logErr(end))))

%% ukazka imnoise 
dataNumsNoise = imnoise(im2double(input),'salt & pepper', 0.3);

for j = 1:1:10
if (j<6)
    figure(3);
    subplot(5,5,5*j-4);
    imshow(reshape(dataNumsNoise(j,:),18,18));
    subplot(5,5,(j-1)*5+2:(j-1)*5+5);
else
    figure(4);
    subplot(5,5,5*(j-5)-4);
    imshow(reshape(dataNumsNoise(j,:),18,18)); 
    subplot(5,5,((j-5)-1)*5+2:((j-5)-1)*5+5);
end
summ = dataNumsNoise(j,:);
vys1 = tanh(w1(:,:)*[summ 1]');
vys2 = tanh(w2(:,:)*[vys1;1]);
vys3 = tanh(w3(:,:)*[vys2;1]);
bar(vys3);
end

